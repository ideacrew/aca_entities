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

            has_many :VerificationAnswers, VerificationAnswer

            def self.domain_to_mapper(verification_answer_set)
              mapper = self.new
              mapper.VerificationAnswers = verification_answer_set.VerificationAnswers.collect do |verification_answer|
                VerificationAnswer.domain_to_mapper(verification_answer)
              end
              mapper
            end
          end
        end
      end
    end
  end
end