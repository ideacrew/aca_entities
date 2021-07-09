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

            tag 'VerificationQuestionSet'
            namespace 'ext'

            element :VerificationQuestionText, String, tag: 'VerificationQuestionText'
            element :VerificationAnswerChoiceText, String, tag: 'VerificationAnswerChoiceText'

            def self.domain_to_mapper(_verification_question_set)
              self.new
            end
          end
        end
      end
    end
  end
end