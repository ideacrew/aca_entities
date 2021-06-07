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
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'VerificationResponse'

            element :session_identification, String, tag: 'SessionIdentification', namespace: 'ext'
            element :dsh_reference_number, String, tag: 'DSHReferenceNumber', namespace: 'ext'
            element :final_decision_code, String, tag: 'FinalDecisionCode', namespace: 'ext'

            has_one :verification_questions, VerificationQuestion, namespace: 'VerificationQuestions'

            def self.domain_to_mapper(verification_response)
              mapper = self.new
              mapper.version = "1.0"
              mapper.session_identification = verification_response.session_identification
              mapper.dsh_reference_number = verification_response.dsh_reference_number
              mapper.final_decision_code = verification_response.final_decision_code
              mapper.verification_questions = VerificationQuestion.domain_to_mapper(verification_response.verification_questions)
              mapper
            end
          end
        end
      end
    end
  end
end