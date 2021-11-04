# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Transformers
      module Ridp
        # AcaEntities::Fdsh::Operations::Ridp::GeneratePrimaryRequestPayload
        class PersonToPrimaryRequest < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          namespace 'person_name' do
            map 'first_name', 'Person.PersonName.PersonGivenName', function: ->(v) { v.gsub(/[^A-Za-z]/, '')}
            map 'middle_name', 'Person.PersonName.PersonMiddleName', function: ->(v) { v.gsub(/[^A-Za-z]/, '')}
            map 'last_name', 'Person.PersonName.PersonSurName', function: ->(v) { v.gsub(/[^A-Za-z]/, '')}
            map 'name_sfx', 'Person.PersonName.PersonNameSuffixText', function: ->(v) { v.gsub(/[^A-Za-z]/, '')}
          end

          namespace 'person_demographics' do
            rewrap '' do
              map 'dob', 'Person.PersonBirthDate'
              map 'ssn', 'Person.PersonSSNIdentification'

              map 'language_code', 'language_code', memoize: true, visible: false

              add_key 'PersonLanguagePreference', function: lambda { |v|
                lan_mapper = { 'en' => 'eng', 'es' => 'spa' }
                v.nil? ? 'eng' : lan_mapper[v.resolve('language_code').item]
              }
            end
          end

          namespace 'home_address' do
            map 'address_1', 'CurrentAddress.LocationAddress.StructuredAddress.LocationStreet.StreetName'
            map 'city', 'CurrentAddress.LocationAddress.StructuredAddress.LocationCityName', function: ->(v) { v.gsub(/[^0-9A-Za-z]/, '')}
            map 'state', 'CurrentAddress.LocationAddress.StructuredAddress.LocationStateUSPostalServiceCode'
            map 'zip', 'CurrentAddress.LocationAddress.StructuredAddress.LocationPostalCode'
          end

          namespace 'home_phone' do
            map 'full_phone_number', 'ContactInformation.ContactTelephoneNumber.FullTelephoneNumber'
          end
        end
      end
    end
  end
end
