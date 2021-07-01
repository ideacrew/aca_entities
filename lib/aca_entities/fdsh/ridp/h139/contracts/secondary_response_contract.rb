# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # contract for SecondaryResponse
        class SecondaryResponseContract < Dry::Validation::Contract

          params do
            required(:Response).schema do
              required(:ResponseMetadata).schema do
                required(:ResponseCode).filled(:string)
                required(:ResponseDescriptionText).filled(:string)
                optional(:TDSResponseDescriptionText).maybe(:string)
              end
              required(:VerificationResponse).schema do
                required(:FinalDecisionCode).filled(:string)
                required(:DSHReferenceNumber).filled(:string)
                optional(:SessionIdentification).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end