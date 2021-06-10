# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # contract for SecondaryResponse
        class SecondaryResponseContract < Dry::Validation::Contract

          params do
            required(:ResponseCode).filled(:string)
            required(:ResponseDescriptionText).filled(:string)
            required(:FinalDecisionCode).filled(:string)
            required(:DSHReferenceNumber).filled(:string)
            optional(:TDSResponseDescriptionText).maybe(:string)
            optional(:SessionIdentification).maybe(:string)
          end
        end
      end
    end
  end
end