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
            required(:VerificationQuestionText).array(:string)
            required(:VerificationAnswerChoiceText).array(:string)
          end
        end
      end
    end
  end
end