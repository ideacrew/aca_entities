# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # VerificationResponse.
          class VerificationResponse
            include HappyMapper
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'

            tag 'VerificationResponse'
            namespace 'ext'

            element :SessionIdentification, String, tag: 'SessionIdentification'
            element :DSHReferenceNumber, String, tag: 'DSHReferenceNumber'
            element :FinalDecisionCode, String, tag: 'FinalDecisionCode'

            has_one :verification_questions, VerificationQuestion

            def self.domain_to_mapper(verification_response)
              mapper = self.new
              mapper.verification_questions = VerificationQuestion.domain_to_mapper(verification_response.verification_questions)
              mapper
            end
          end
        end
      end
    end
  end
end