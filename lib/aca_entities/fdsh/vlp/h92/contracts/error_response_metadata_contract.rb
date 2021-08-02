# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp ResponseMetadata
        class ErrorResponseMetadataContract < Dry::Validation::Contract
          params do
            required(:ErrorResponseCode).filled(:string)
            required(:ErrorResponseDescriptionText).filled(:string)
            optional(:ErrorTdsResponseDescriptionText).maybe(:string)
          end
        end
      end
    end
  end
end