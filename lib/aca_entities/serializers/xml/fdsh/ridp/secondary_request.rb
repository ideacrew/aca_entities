# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # SecondaryResponse.
          class SecondaryResponse
            include HappyMapper
            register_namespace 'ex', 'http://ridp.dsh.cms.gov/exchange/1.0'
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'

            tag 'SecondaryRequest'

            element :session_identification, String, tag: 'SessionIdentification'
            has_one :verification_answer_set, VerificationAnswerSet, namespace: 'VerificationAnswerSet'

            def self.domain_to_mapper(secondary_response)
              mapper = self.new
              mapper.version = "1.0"
              mapper.session_identification = VerificationAnswerSet.domain_to_mapper(secondary_response.verification_answer_set)
              mapper.session_identification = secondary_response.session_identification
              mapper
            end
          end
        end
      end
    end
  end
end