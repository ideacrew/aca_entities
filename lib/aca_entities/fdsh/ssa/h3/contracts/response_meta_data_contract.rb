# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification response contract
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