# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx1424
        module Contracts
          # Contract for Fdsh Vlp ResponseMetadata
          class ArrayOfErrorResponseMetadataContract < Dry::Validation::Contract
            params do
              required(:ErrorResponseMetadatas).array(Fdsh::Vlp::Rx1424::Contracts::ErrorResponseMetadataContract.params)
            end
          end
        end
      end
    end
  end
end