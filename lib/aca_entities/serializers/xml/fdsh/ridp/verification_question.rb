# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # VerificationQuestion.
          class VerificationQuestion
            include HappyMapper
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'VerificationQuestions'

            has_many :verification_question_set, VerificationQuestionSet

            def self.domain_to_mapper(verification_questions)
              mapper = self.new
              mapper.version = "1.0"
              mapper.verification_question_set = [VerificationQuestionSet.domain_to_mapper(verification_questions.verification_question_set)]
              mapper
            end
          end
        end
      end
    end
  end
end