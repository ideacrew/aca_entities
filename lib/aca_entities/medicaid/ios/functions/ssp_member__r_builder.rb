# frozen_string_literal: true

require 'aca_entities/medicaid/ios/types'

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Member__c for IOS transform
        class SspMemberRBuilder
          include ::AcaEntities::Operations::Transforms::HashFunctions

          def resolve_hispanic(options)
            return "false" if options.nil? || options.empty?
            !(options & AcaEntities::Medicaid::Ios::Types::HISPANIC_MAP).empty?
          end

          def decrypt_ssn(encrypted_ssn)
            result = AcaEntities::Operations::Encryption::Decrypt.new.call({ value: encrypted_ssn })
            return nil unless result.success?
            result.value!
          end

          def call(applicant)
            home_address = applicant[:addresses].detect {|address| address[:kind] == 'home'}
            {
              :IsFixedAddressToggle__c => boolean_string(!applicant[:is_homeless]),
              :In_Which_City_Town_Applicant_Live__c => home_address&.dig(:city),
              :FirstName__c => applicant&.dig(:name, :first_name),
              :LastName__c => applicant&.dig(:name, :last_name),
              :PhysicalCity__c => home_address&.dig(:city),
              :PhysicalStateCode__c => home_address&.dig(:state),
              :PhysicalZipCode5__c => home_address&.dig(:zip)&.split('-')&.at(0),
              :PhysicalAddressLine2__c => home_address&.dig(:address_line_2),
              :BirthDate__c => applicant&.dig(:demographic, :dob),
              :GenderCode__c => AcaEntities::Medicaid::Ios::Types::GENDER_MAP[applicant&.dig(:demographic, :gender)&.downcase],
              :IsHispanicLatinoSpanishToggle__c => boolean_string(resolve_hispanic(applicant&.dig(:demographic, :ethnicity))),
              :IsIntendToResideToggle__c => boolean_string(home_address&.dig(:state) == "ME"),
              :MiddleInitial__c => applicant&.dig(:name, :middle_name)&.chars&.first&.upcase,
              :SuffixCode__c => applicant&.dig(:name, :suffix)&.upcase,
              :RaceCode__c => AcaEntities::Medicaid::Ios::Types::RACE_MAP[applicant&.dig(:demographic, :gender)],
              #:NoReasonSSNCode__c => resolve_no_ssn_reason(:applicant),
              :SSN__c => decrypt_ssn(applicant&.dig(:identifying_information, :encrypted_ssn)),
              :IsMilitaryMemberToggle__c => boolean_string(applicant&.dig(:demographic, :is_veteran_or_active_military)),
              :HasSSN__c => boolean_string(applicant&.dig(:identifying_information, :has_ssn))
            }
          end
        end
      end
    end
  end
end