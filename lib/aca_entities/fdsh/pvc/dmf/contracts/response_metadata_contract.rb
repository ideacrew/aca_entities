# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Contracts
          # Contract for FDSH ResponseMetaDataContract
          class ResponseMetadataContract < Dry::Validation::Contract
            params do
              required(:ResponseCode).filled(:string)
              required(:ResponseDescriptionText).filled(:string)
              optional(:TDSResponseDescriptionText).maybe(:string)
            end
          end
        end
      end
    end
  end
end