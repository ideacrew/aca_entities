# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
          module Contracts
            # Contract for Fdsh Vlp ResponseMetadata
            class ArrayOfErrorResponseMetadataContract < Dry::Validation::Contract
              params do
                required(:ErrorResponseMetadatas).array(Fdsh::Vlp::Rx142::CloseCase::Contracts::ErrorResponseMetadataContract.params)
              end
            end
          end
        end
      end
    end
  end
end