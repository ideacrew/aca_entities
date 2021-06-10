# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # VerificationQuestionSet.
          class VerificationQuestionSet
            include HappyMapper
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'VerificationQuestionSet'

            element :VerificationQuestionText, String, tag: 'VerificationQuestionText'
            element :VerificationAnswerChoiceText, String, tag: 'VerificationAnswerChoiceText'

            def self.domain_to_mapper(verification_question_set)
              mapper = self.new
              mapper.VerificationQuestionText = verification_question_set.VerificationQuestionText
              mapper.VerificationAnswerChoiceText = verification_question_set.VerificationAnswerChoiceText
              mapper
            end
          end
        end
      end
    end
  end
end