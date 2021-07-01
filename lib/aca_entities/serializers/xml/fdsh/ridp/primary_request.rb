# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # PrimaryRequest.
          class PrimaryRequest
            include HappyMapper
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'

            tag 'PrimaryRequest'
            namespace 'ext'

            has_one :Person, Person
            has_one :CurrentAddress, CurrentAddress
            has_one :ContactInformation, ContactInformation
            element :LevelOfProofingCode, String, tag: 'LevelOfProofingCode'
            element :SubscriberNumber, String, tag: 'SubscriberNumber'
            element :PersonLanguagePreference, String, tag: 'PersonLanguagePreference'

            def self.domain_to_mapper(initial_primary_request)
              mapper = self.new
              mapper.Person = Person.domain_to_mapper(initial_primary_request.Person)
              mapper.CurrentAddress = CurrentAddress.domain_to_mapper(initial_primary_request.CurrentAddress)
              mapper.ContactInformation = ContactInformation.domain_to_mapper(initial_primary_request.ContactInformation)

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
