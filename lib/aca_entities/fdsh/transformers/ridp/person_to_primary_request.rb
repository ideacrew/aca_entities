# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Transformers
      module Ridp
        # rubocop:disable Style/Lambda
        # AcaEntities::Fdsh::Operations::Ridp::GeneratePrimaryRequestPayload
        class PersonToPrimaryRequest < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          namespace 'person_name' do
            rewrap '', type: :hash do
              map 'first_name', 'PersonGivenName'
              map 'middle_name', 'PersonMiddleName'
              map 'last_name', 'PersonSurName'
              map 'name_sfx', 'PersonNameSuffixText'
            end
          end

          namespace 'person_demographics' do
            rewrap '', type: :hash do
              map 'dob', 'PersonBirthDate'
              map 'ssn', 'PersonSSNIdentification'
              map 'language_code', 'PersonLanguagePreference'
            end
          end

          map 'home_address', 'home_address',  memoize_record: true, visible: false

          add_key 'StreetName', function: ->(v) {
            h_address = v.resolve('home_address').item
            [h_address[:address_1], h_address[:address_2], h_address[:address_3]].reject(&:nil?).join(' ')
          }

          add_key 'LocationCityName', function: ->(v) {
            h_address = v.resolve('home_address').item
            h_address[:city]
          }

          add_key 'LocationStateUSPostalServiceCode', function: ->(v) {
            h_address = v.resolve('home_address').item
            h_address[:state]
          }

          add_key 'LocationPostalCode', function: ->(v) {
            h_address = v.resolve('home_address').item
            h_address[:zip]
          }

          namespace 'home_phone' do
            rewrap '', type: :hash do
              map 'full_phone_number', 'FullTelephoneNumber'
            end
          end
        end
        # rubocop:enable Style/Lambda
      end
    end
  end
end
