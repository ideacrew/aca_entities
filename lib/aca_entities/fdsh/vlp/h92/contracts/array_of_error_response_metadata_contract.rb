# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp ResponseMetadata
        class ArrayOfErrorResponseMetadataContract < Dry::Validation::Contract
          params do
            required(:ErrorResponseMetadatas).array(Fdsh::Vlp::H92::ErrorResponseMetadataContract.params)
          end
        end
      end
    end
  end
end