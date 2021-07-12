# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # contract for PrimaryResponse
        class PrimaryResponseContract < Dry::Validation::Contract
          params do
            required(:Response).schema do
              required(:ResponseMetadata).schema do
                required(:ResponseCode).filled(:string)
                required(:ResponseDescriptionText).filled(:string)
                optional(:TDSResponseDescriptionText).maybe(:string)
              end

              required(:VerificationResponse).schema do
                optional(:SessionIdentification).maybe(:string)
                optional(:DSHReferenceNumber).maybe(:string)
                optional(:FinalDecisionCode).maybe(:string)

                optional(:VerificationQuestions).schema do
                  optional(:VerificationQuestionSet).array(:hash) do
                    optional(:VerificationQuestionText).filled(:string)
                    optional(:VerificationAnswerChoiceText).array(:string)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
