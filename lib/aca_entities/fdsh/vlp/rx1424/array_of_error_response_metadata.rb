# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx1424
        # Entity for Fdsh Vlp ArrayOfErrorResponseMetadata
        class ArrayOfErrorResponseMetadata < Dry::Struct
          attribute :ErrorResponseMetadatas,    Types::Array.of(Fdsh::Vlp::Rx1424::ErrorResponseMetadata).meta(omittable: false)
        end
      end
    end
  end
end