# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        module Contracts
          # Contract for FDSH ESI Verification contract
          class ResponseMetadataContract < Dry::Validation::Contract
            params do
              required(:ResponseCode).filled(:string)
              required(:ResponseDescriptionText).filled(:string)
            end
          end
        end
      end
    end
  end
end