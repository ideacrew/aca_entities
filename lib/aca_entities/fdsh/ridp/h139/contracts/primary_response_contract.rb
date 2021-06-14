# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # contract for PrimaryResponse
        class PrimaryResponseContract < Dry::Validation::Contract
          params do
            required(:ResponseCode).filled(:string)
            required(:ResponseDescriptionText).filled(:string)
            optional(:TDSResponseDescriptionText).maybe(:string)
            optional(:SessionIdentification).maybe(:string)
            optional(:DSHReferenceNumber).maybe(:string)
            optional(:FinalDecisionCode).maybe(:string)

            required(:VerificationQuestionSet).array(:hash) do
              required(:VerificationQuestionText).filled(:string)
              required(:VerificationAnswerChoiceText).filled(:string)
            end
          end
        end
      end
    end
  end
end