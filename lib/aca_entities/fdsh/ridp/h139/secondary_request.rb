# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for SecondaryRequest
        class SecondaryRequest < Dry::Struct
          attribute :VerificationAnswerSet do
            attribute :VerificationAnswers, Types::Array do
              attribute :VerificationQuestionNumber, Types::Integer.meta(omittable: false)
              attribute :VerificatonAnswer, Types::Integer.meta(omittable: false)
            end
          end

          attribute :SessionIdentification,         Types::String.meta(omittable: false)

        end
      end
    end
  end
end