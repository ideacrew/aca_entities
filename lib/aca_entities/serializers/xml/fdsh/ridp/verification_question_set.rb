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

            element :verification_question_text, String, tag: 'VerificationQuestionText'
            element :verification_answer_choice_text, String, tag: 'VerificationAnswerChoiceText'

            def self.domain_to_mapper(verification_question_set)
              mapper = self.new
              mapper.version = "1.0"
              mapper.verification_question_text = verification_question_set.verification_question_text
              mapper.verification_answer_choice_text = verification_question_set.verification_answer_choice_text
              mapper
            end
          end
        end
      end
    end
  end
end