# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_HealthInsuranceFacilityType__c for IOS transform
        class SspHealthInsuranceFacilityTypeCBuilder
          def call(cache)
            @memoized_data = cache
            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            applicants = application[:applicants]
            applicants.map do |applicant|
              next unless applicant[:benefits] && applicant[:benefits].any?
              applicant[:benefits].map do |benefit|
                {
                  "CoverageStartDate__c" => benefit&.dig(:start_on),
                  "CoverageEndDate__c" => benefit&.dig(:end_on),
                  "Id" => SecureRandom.uuid.gsub("-", ""),
                  "FacilityType__c" => "MD",
                  "SSP_InsuranceCoveredIndiv__c" => applicant&.dig(:hbx_id)
                }
              end
            end.flatten.compact
          end
        end
      end
    end
  end
end