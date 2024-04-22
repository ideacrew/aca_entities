# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
          module Contracts
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
  end
end