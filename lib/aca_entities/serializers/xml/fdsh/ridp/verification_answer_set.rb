# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # VerificationAnswerSet.
          class VerificationAnswerSet
            include HappyMapper
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'VerificationAnswerSet'

            element :VerificationQuestionNumber, String, tag: 'VerificationQuestionNumber'
            element :VerificatonAnswer, String, tag: 'VerificatonAnswer'

            def self.domain_to_mapper(verification_answer_set)
              mapper = self.new
              mapper.VerificationQuestionNumber = verification_answer_set.VerificationQuestionNumber
              mapper.VerificatonAnswer = verification_answer_set.VerificatonAnswer
              mapper
            end
          end
        end
      end
    end
  end
end