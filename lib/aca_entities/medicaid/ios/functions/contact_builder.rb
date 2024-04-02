# frozen_string_literal: true

require 'aca_entities/medicaid/ios/types'

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build contact for IOS transform
        class ContactBuilder
          include ::AcaEntities::Operations::Transforms::HashFunctions

          def decrypt_ssn(encrypted_ssn)
            result = AcaEntities::Operations::Encryption::Decrypt.new.call({ value: encrypted_ssn })
            return nil unless result.success?
            result.value!
          end

          # rubocop:disable Metrics/CyclomaticComplexity
          def call(cache)
            application = cache.resolve('family.magi_medicaid_applications').item
            primary_applicant = application[:applicants].detect {|applicant| applicant[:is_primary_applicant]}
            people = cache.resolve('family.family_members').item
            person = people&.detect {|per| per[:is_primary_applicant]}
            primary_phone = primary_applicant[:phones].detect { |num| num[:primary] == true }

            [{
              "Birthdate" => primary_applicant&.dig(:demographic, :dob),
              "Email" => primary_applicant&.dig(:emails)&.first&.dig(:address),
              "FirstName" => primary_applicant&.dig(:name, :first_name),
              "LastName" => primary_applicant&.dig(:name, :last_name),
              "GenderCode__c" => AcaEntities::Medicaid::Ios::Types::GENDER_MAP[primary_applicant&.dig(:demographic, :gender)&.downcase],
              "MailingAddressLine2" => primary_applicant&.dig(:addresses)&.first&.dig(:address_line_2),
              "PreferredLanguageCode__c" => person&.dig(:demographics, :language_code)&.downcase,
              "PrimaryPhoneExtension__c" => primary_phone&.dig(:extension),
              "PrimaryPhoneNumber__c" => convert_to_phone(primary_phone&.dig(:full_phone_number)),
              "SSN__c" => decrypt_ssn(primary_applicant&.dig(:identifying_information, :encrypted_ssn)),
              "SuffixCode__c" => primary_applicant&.dig(:name, :name_sfx)&.upcase,
              "Id" => primary_applicant&.dig(:person_hbx_id),
              "MiddleName" => primary_applicant&.dig(:name, :middle_name),
              "Phone" => convert_to_phone(primary_phone&.dig(:full_phone_number))
            }]
          end
          # rubocop:enable Metrics/CyclomaticComplexity
        end
      end
    end
  end
end