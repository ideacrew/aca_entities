# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp ResponseMetadata
        class ResponseMetadataContract < Dry::Validation::Contract
          params do
            required(:ResponseCode).filled(:string)
            required(:ResponseDescriptionText).filled(:string)
            optional(:TdsResponseDescriptionText).maybe(:string)
          end
        end
      end
    end
  end
end