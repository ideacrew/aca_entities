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
            family = yield validate(family)
            primary_family_member = yield fetch_primary_family_member(family)
            result = yield transform_family(primary_family_member, family)

            Success(result)
          end

          private

          def validate(family)
            return Failure("Invalid family object: #{family.class}") unless family.is_a?(AcaEntities::Families::Family)
            Success(family)
          end

          def fetch_primary_family_member(family)
            primary_family_member = family.family_members.detect(&:is_primary_applicant)
            return Failure("Primary family member not found") unless primary_family_member.present?
            Success(primary_family_member)
          end

          def transform_family(primary_family_member, family)
            primary_person = primary_family_member.person
            addresses = primary_person.addresses

            Success(
              {
                hbxid_c: primary_person.hbx_id,
                name: primary_person.person_name.full_name,
                email1: fetch_email(primary_person.emails),
                billing_address_street: fetch_address(addresses, 'billing_address_street'),
                billing_address_street2: fetch_address(addresses, 'billing_address_street2'),
                billing_address_street3: fetch_address(addresses, 'billing_address_street3'),
                billing_address_street4: nil,
                billing_address_city: fetch_address(addresses, 'billing_address_city'),
                billing_address_postalcode: fetch_address(addresses, 'billing_address_postalcode'),
                billing_address_state: fetch_address(addresses, 'billing_address_state'),
                phone_office: fetch_phone_number(primary_person.phones),
                rawssn_c: decrypt_ssn(primary_person.person_demographics.encrypted_ssn),
                raw_ssn_c: decrypt_ssn(primary_person.person_demographics.encrypted_ssn),
                dob_c: primary_person&.person_demographics&.dob&.to_s,
                enroll_account_link_c: primary_person.external_person_link,
                contacts: transform_contacts(family.family_members, primary_person)
              }
            )
          rescue StandardError => e
            Failure("Unable to transform Sugar Account: #{e.message}, backtrace: #{e.backtrace}")
          end

          def fetch_email(emails)
            emails.detect {|email| email.kind == "home"}.try(:address) || emails.detect {|email| email.kind == "work"}.try(:address)
          end

          def fetch_address(addresses, kind)
            case kind
            when 'billing_address_street'
              addresses.first.try(:address_1)
            when 'billing_address_street2'
              addresses.first.try(:address_2)
            when 'billing_address_street3'
              addresses.first.try(:address_3)
            when 'billing_address_city'
              addresses.first.try(:city)
            when 'billing_address_postalcode'
              addresses.first.try(:zip)
            when 'billing_address_state'
              addresses.first.try(:state)
            end
          end

          def fetch_phone_number(phones)
            phones.detect {|phone| phone.kind == "mobile"}.try(:full_phone_number) || phones.detect do |phone|
              phone.kind == "home"
            end.try(:full_phone_number)
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
            matched_relative&.kind
          end

          def transform_contacts(family_members, primary_person)
            family_members.map do |family_member|
              next unless family_member.person.present?
              hbx_id = family_member.person.hbx_id
              {
                hbxid_c: hbx_id,
                first_name: family_member.person.person_name.first_name,
                last_name: family_member.person.person_name.last_name,
                phone_mobile: fetch_phone_number(family_member.person.phones),
                email1: fetch_email(family_member.person.emails),
                birthdate: family_member&.person&.person_demographics&.dob&.to_s,
                relationship_c: fetch_relationship_to_primary(hbx_id, primary_person)
              }
            end
          end
        end
      end
    end
  end
end
