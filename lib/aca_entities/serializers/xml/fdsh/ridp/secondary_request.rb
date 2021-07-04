# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # SecondaryRequest.
          class SecondaryRequest
            include HappyMapper
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'

            tag 'SecondaryRequest'
            namespace 'ext'

            element :SessionIdentification, String, tag: 'SessionIdentification'
            has_one :VerificationAnswerSet, VerificationAnswerSet

            def self.domain_to_mapper(secondary_request)
              mapper = self.new
              mapper.SessionIdentification = secondary_request.SessionIdentification
              mapper.VerificationAnswerSet = VerificationAnswerSet.domain_to_mapper(secondary_request.VerificationAnswerSet)
              mapper
            end
          end
        end
      end
    end
  end
end