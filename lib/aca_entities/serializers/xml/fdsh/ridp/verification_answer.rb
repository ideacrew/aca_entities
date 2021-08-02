# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # VerificationAnswer.
          class VerificationAnswer
            include HappyMapper
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'

            tag 'VerificationAnswers'
            namespace 'ext'

            element :VerificatonAnswer, String, tag: 'VerificatonAnswer'
            element :VerificationQuestionNumber, String, tag: 'VerificationQuestionNumber'

            def self.domain_to_mapper(verification_answer)
              mapper = self.new
              mapper.VerificatonAnswer = verification_answer.VerificatonAnswer
              mapper.VerificationQuestionNumber = verification_answer.VerificationQuestionNumber
              mapper
            end
          end
        end
      end
    end
  end
end