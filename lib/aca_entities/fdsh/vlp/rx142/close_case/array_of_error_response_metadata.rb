# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
          # Entity for Fdsh Vlp ArrayOfErrorResponseMetadata
          class ArrayOfErrorResponseMetadata < Dry::Struct
            attribute :ErrorResponseMetadatas,    Types::Array.of(Fdsh::Vlp::Rx142::CloseCase::ErrorResponseMetadata).meta(omittable: false)
          end
        end
      end
    end
  end
end