# frozen_string_literal: true

require 'json'
require "json-schema"

module AcaEntities
  module Fdsh
    module Ridp
      module Rj139
        module Operations
          # convert person entity to ridp primary request
          class PersonToPrimaryRequest
            include Dry::Monads[:result, :do, :try]

            def call(params)
              payload = yield construct_initial_request(params)
              validate_payload(payload)
            end

            private

            def construct_initial_request(payload)
              request = { ridpRequest: { primaryRequest: construct_primary_request(payload) } }
              Success(request)
            end

            def construct_primary_request(payload)
              {
                person: construct_person_demographics(payload),
                contactInformation: construct_contact_information(payload)
              }
            end

            def construct_person_demographics(payload)
              {
                personSurName: payload.person_name.last_name&.gsub(/[^A-Za-z]/, ''),
                personMiddleName: payload.person_name.middle_name&.gsub(/[^A-Za-z]/, ''),
                personGivenName: payload.person_name.first_name&.gsub(/[^A-Za-z]/, ''),
                personBirthDate: construct_birth_date(payload),
                personSuffixName: payload.person_name.name_sfx&.gsub(/[^A-Za-z]/, ''),
                personSocialSecurityNumber: decrypt_ssn(payload.person_demographics.encrypted_ssn),
                personPreferredLanguage: construct_language_code(payload.person_demographics&.language_code)
              }
            end

            def construct_language_code(language_preference)
              lan_mapper = { 'en' => 'eng', 'es' => 'spa' }
              return 'eng' unless lan_mapper.keys.include?(language_preference)
              lan_mapper[language_preference]
            end

            def construct_birth_date(person)
              person&.person_demographics&.dob
            end

            def decrypt_ssn(encrypted_ssn)
              return nil if encrypted_ssn.blank?

              AcaEntities::Operations::Encryption::Decrypt.new.call({ value: encrypted_ssn }).value!
            end

            def construct_contact_information(payload)
              home_address = payload.home_address || payload.addresses&.last
              home_phone = payload.phones ? (payload.home_phone || payload.phones&.last) : nil
              {
                streetName: home_address&.address_1&.gsub(/[^0-9A-Za-z\s]/, ''),
                cityName: home_address&.city&.gsub(/[^0-9A-Za-z]/, ''),
                usStateCode: home_address&.state,
                zipCode: home_address&.zip,
                telephoneNumber: home_phone&.full_phone_number
              }
            end

            def validate_payload(payload)
              schema_data = JSON.parse(File.read(Pathname.pwd.join("lib/aca_entities/fdsh/ridp/rj139/schemas/RIDP-Request-schema.json")))

              # CMS requested no blank data be sent in the request
              payload[:ridpRequest][:primaryRequest][:person].delete_if { |_k, v| v.blank? }
              payload[:ridpRequest][:primaryRequest][:contactInformation].delete_if { |_k, v| v.blank? }

              result = begin
                JSON::Validator.fully_validate(schema_data, JSON.parse(payload.to_json))
              rescue JSON::Schema::ValidationError => e
                e.message
              end
              result.empty? ? Success(payload.to_json) : Failure(result.to_s)
            end
          end
        end
      end
    end
  end
end