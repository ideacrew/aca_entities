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
            element :level_of_proofing_code, String, tag: 'LevelOfProofingCode'
            element :subscriber_number, String, tag: 'SubscriberNumber'
            element :person_language_preference, String, tag: 'PersonLanguagePreference'

            def self.domain_to_mapper(initial_primary_request)
              mapper = self.new
              mapper.version = "1.0"
              mapper.person = Person.domain_to_mapper(initial_primary_request.person)
              mapper.current_address = CurrentAddress.domain_to_mapper(initial_primary_request.current_address)
              mapper.contact_information = ContactInformation.domain_to_mapper(initial_primary_request.contact_information)

              mapper.level_of_proofing_code = initial_primary_request.contact_information
              mapper.subscriber_number = initial_primary_request.contact_information
              mapper.person_language_preference = initial_primary_request.contact_information
              mapper
            end
          end
        end
      end
    end
  end
end