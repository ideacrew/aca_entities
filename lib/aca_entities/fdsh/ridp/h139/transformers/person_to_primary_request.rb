# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Transformers
      module Ridp
        # AcaEntities::Fdsh::Operations::Ridp::GeneratePrimaryRequestPayload
        class PersonToPrimaryRequest < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          namespace 'person_name' do
            map 'first_name', 'Person.PersonName.PersonGivenName'
            map 'middle_name', 'Person.PersonName.PersonMiddleName'
            map 'last_name', 'Person.PersonName.PersonSurName'
            map 'name_sfx', 'Person.PersonName.PersonNameSuffixText'
          end

          namespace 'person_demographics' do
            map 'dob', 'Person.PersonBirthDate'
            map 'ssn', 'Person.PersonSSNIdentification'
            map 'language_code', 'PersonLanguagePreference'
          end

          namespace 'home_address' do
            map 'address_1', 'CurrentAddress.LocationAddress.StructuredAddress.LocationStreet.StreetName'
            map 'city', 'CurrentAddress.LocationAddress.StructuredAddress.LocationCityName'
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
