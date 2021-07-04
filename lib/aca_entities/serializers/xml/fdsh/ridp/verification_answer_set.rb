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

            tag 'VerificationAnswerSet'
            namespace 'ext'

            has_many :verification_answers, VerificationAnswer

            def self.domain_to_mapper(verification_answer_set)
              mapper = self.new
              mapper.verification_answers = [VerificationAnswer.domain_to_mapper(verification_answer_set.verification_answers)]
              mapper
            end
          end
        end
      end
    end
  end
end