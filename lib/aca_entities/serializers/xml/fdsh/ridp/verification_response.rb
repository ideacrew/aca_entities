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

            element :SessionIdentification, String, tag: 'SessionIdentification', namespace: 'ext'
            element :DSHReferenceNumber, String, tag: 'DSHReferenceNumber', namespace: 'ext'
            element :FinalDecisionCode, String, tag: 'FinalDecisionCode', namespace: 'ext'

            has_one :verification_questions, VerificationQuestion, namespace: 'VerificationQuestions'

            def self.domain_to_mapper(verification_response)
              mapper = self.new
              mapper.SessionIdentification = verification_response.SessionIdentification
              mapper.DSHReferenceNumber = verification_response.DSHReferenceNumber
              mapper.FinalDecisionCode = verification_response.FinalDecisionCode
              mapper.verification_questions = VerificationQuestion.domain_to_mapper(verification_response.verification_questions)
              mapper
            end
          end
        end
      end
    end
  end
end