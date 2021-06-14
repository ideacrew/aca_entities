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

            element :VerificationQuestionNumber, String, tag: 'VerificationQuestionNumber'
            element :VerificatonAnswer, String, tag: 'VerificatonAnswer'

            def self.domain_to_mapper(_verification_questions)
              self.new
            end
          end
        end
      end
    end
  end
end