# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_InsuranceCoveredIndiv__c for IOS transform
        class SspInsuranceCoveredIndivCBuilder
          include ::AcaEntities::Operations::Transforms::HashFunctions

          def decrypt_ssn(encrypted_ssn)
            result = AcaEntities::Operations::Encryption::Decrypt.new.call({ value: encrypted_ssn })
            return nil unless result.success?
            result.value!
          end

          def call(cache)
            application = cache.resolve('family.magi_medicaid_applications').item
            applicants = application[:applicants]
            applicants.map do |applicant|
              next unless applicant[:benefits]&.any?
              applicant[:benefits].map do |benefit|
                {
                  "DateofBirth__c" => applicant&.dig(:demographic, :dob),
                  "FirstName__c" => applicant&.dig(:name, :first_name),
                  "Gender__c" => AcaEntities::Medicaid::Ios::Types::GENDER_MAP[applicant&.dig(:demographic, :gender)&.downcase],
                  "IsEnrolled__c" => benefit[:is_enrolled],
                  "LastName__c" => applicant&.dig(:name, :last_name),
                  "SSN__c" => decrypt_ssn(applicant&.dig(:identifying_information, :encrypted_ssn)),
                  "SSP_Member__c" => applicant&.dig(:person_hbx_id),
                  "SuffixCode__c" => applicant&.dig(:name, :name_sfx)&.upcase,
                  "IsInsuranceCovered__c" => boolean_string(benefit&.dig(:status) == "is_enrolled"), # we need to add additional logic for dependents
                  "IsPolicyHolder__c" => boolean_string(benefit&.dig(:esi_covered) == "self"),
                  "Id" => SecureRandom.uuid.gsub("-", "")
                  # if the next items are supposed to be a foreign id , we need to add logic to resolve the id
                  # "SSP_Member__c"
                  # "SSP_InsurancePolicy__c"
                  # "SSP_Member__r"
                }
              end
            end.flatten.compact
          end
        end
      end
    end
  end
end