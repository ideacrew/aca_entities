# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'aca_entities/types'

module AcaEntities
  module Crm
    module Transformers
      module FamilyTo
        # Transforms a Family Entity to an Account entity
        class Account
          include Dry::Monads[:do, :result]

          def call(family)
            family                = yield validate(family)
            primary_family_member = yield fetch_primary_family_member(family)
            result                = yield transform_family(primary_family_member, family)

            Success(result)
          end

          private

          def validate(family)
            if family.is_a?(AcaEntities::Families::Family)
              Success(family)
            else
              Failure("Invalid family object: #{family.class}")
            end
          end

          def fetch_primary_family_member(family)
            primary_family_member = family.family_members.detect(&:is_primary_applicant)
            if primary_family_member.present?
              Success(primary_family_member)
            else
              Failure("Primary family member not found")
            end
          end

          def transform_family(primary_family_member, family)
            primary_person = primary_family_member.person
            raw_ssn = decrypt_ssn(primary_person.person_demographics.encrypted_ssn)

            Success(
              {
                hbxid_c: primary_person.hbx_id,
                name: primary_person.person_name.full_name,
                email1: primary_person.home_email || primary_person.work_email,
                billing_address_street: fetch_address(primary_person, 'billing_address_street'),
                billing_address_street_2: fetch_address(primary_person, 'billing_address_street_2'),
                billing_address_street_3: fetch_address(primary_person, 'billing_address_street_3'),
                billing_address_street_4: nil,
                billing_address_city: fetch_address(primary_person, 'billing_address_city'),
                billing_address_postalcode: fetch_address(primary_person, 'billing_address_postalcode'),
                billing_address_state: fetch_address(primary_person, 'billing_address_state'),
                phone_office: fetch_and_format_phone(primary_person),
                rawssn_c: raw_ssn, raw_ssn_c: raw_ssn,
                dob_c: primary_person&.person_demographics&.dob&.to_s,
                enroll_account_link_c: primary_person.external_person_link,
                contacts: transform_contacts(family.family_members, primary_person)
              }
            )
          rescue StandardError => e
            Failure("Unable to transform Family entity into Account due to: #{e.message}, backtrace: #{e.backtrace}")
          end

          def fetch_address(person, kind)
            address = person.best_address
            case kind
            when 'billing_address_street'
              address.try(:address_1)
            when 'billing_address_street_2'
              address.try(:address_2)
            when 'billing_address_street_3'
              address.try(:address_3)
            when 'billing_address_city'
              address.try(:city)
            when 'billing_address_postalcode'
              address.try(:zip)
            when 'billing_address_state'
              address.try(:state)
            end
          end

          # Fetches a person's phone number and formats it.
          # If the person has a mobile phone, it uses that; otherwise, it falls back to the home phone.
          # The phone number is formatted as "(XXX) XXX-XXXX" where X represents a digit.
          #
          # @param person [Object] The person object expected to respond to `mobile_phone` and `home_phone`.
          # @return [String, nil] The formatted phone number or nil if the person has no phone or the phone number is invalid.
          def fetch_and_format_phone(person)
            phone = person.mobile_phone || person.home_phone
            return nil if phone.blank?

            phone_number = phone.area_code + phone.number
            return nil unless phone_number.match?(/\A\d{10}\z/)

            phone_number.gsub(/(\d{3})(\d{3})(\d{4})/, '(\1) \2-\3')
          end

          def decrypt_ssn(encrypted_ssn)
            return nil unless encrypted_ssn.present?
            result = AcaEntities::Operations::Encryption::Decrypt.new.call(value: encrypted_ssn)
            result.success? ? result.value! : nil
          end

          def fetch_relationship_to_primary(hbx_id, primary_person)
            return "Self" if hbx_id == primary_person.hbx_id

            matched_relative = primary_person.person_relationships.detect do |person_relationship|
              person_relationship.relative.hbx_id == hbx_id
            end
            AcaEntities::Crm::Types::ACA_TO_SUGAR_RELATIONSHIP_MAPPING[matched_relative&.kind]
          end

          def transform_contacts(family_members, primary_person)
            family_members.map do |family_member|
              person = family_member.person
              next unless person.present?
              hbx_id = person.hbx_id
              {
                hbxid_c: hbx_id,
                first_name: person.person_name.first_name,
                last_name: person.person_name.last_name,
                phone_mobile: fetch_and_format_phone(person),
                email1: person.home_email || person.work_email,
                birthdate: person&.person_demographics&.dob&.to_s,
                relationship_c: fetch_relationship_to_primary(hbx_id, primary_person)
              }
            end
          end
        end
      end
    end
  end
end
