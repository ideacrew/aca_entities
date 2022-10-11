# frozen_string_literal: true

require 'aca_entities/medicaid/ios/types'

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_InsurancePolicy__c for IOS transform
        class SspInsurancePolicyCBuilder
          include ::AcaEntities::Operations::Transforms::HashFunctions

          def call(cache)
            @memoized_data = cache

            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            applicants = application[:applicants]
            applicants.map do |applicant|
              next unless applicant[:benefits] && applicant[:benefits].any?
              applicant[:benefits].map do |benefit|
                next if benefit[:esi_covered].nil? # we cannot send without tier
                {
                  'EmployerName__c' => benefit&.dig(:employer, :employer_name),
                  'EnrollmentTierLevel__c' => AcaEntities::Medicaid::Ios::Types::ESI_TIER_MAP[benefit&.dig(:esi_covered)],
                  'IsEnrolledInInsurance__c' => boolean_string(benefit&.dig(:status) == "is_enrolled"),
                  'Is_this_an_empl__c' => boolean_string(benefit&.dig(:is_employer_sponsored)),
                  'PolicyBeginDate__c' => benefit&.dig(:start_on),
                  'Id' => SecureRandom.uuid.gsub("-", "")
                }
              end
            end.flatten.compact
          end
        end
      end
    end
  end
end