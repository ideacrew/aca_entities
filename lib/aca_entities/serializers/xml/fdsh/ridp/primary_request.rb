# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # InitialServiceRequest.
          class InitialServiceRequest
            include HappyMapper
            register_namespace 'ex', 'http://ridp.dsh.cms.gov/exchange/1.0'
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'

            tag 'PrimaryRequest'
            namespace 'ex'

            has_one :person, Person
            has_one :current_address, CurrentAddress
            has_one :contact_information, ContactInformation
            element :LevelOfProofingCode, String, tag: 'LevelOfProofingCode'
            element :SubscriberNumber, String, tag: 'SubscriberNumber'
            element :PersonLanguagePreference, String, tag: 'PersonLanguagePreference'

            def self.domain_to_mapper(initial_primary_request)
              mapper = self.new
              mapper.version = "1.0"
              mapper.person = Person.domain_to_mapper(initial_primary_request.person)
              mapper.current_address = CurrentAddress.domain_to_mapper(initial_primary_request.current_address)
              mapper.contact_information = ContactInformation.domain_to_mapper(initial_primary_request.contact_information)

              mapper.LevelOfProofingCode = initial_primary_request.LevelOfProofingCode
              mapper.SubscriberNumber = initial_primary_request.SubscriberNumber
              mapper.PersonLanguagePreference = initial_primary_request.PersonLanguagePreference
              mapper
            end
          end
        end
      end
    end
  end
end