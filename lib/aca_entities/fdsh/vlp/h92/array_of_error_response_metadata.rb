# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp ArrayOfErrorResponseMetadata
        class ArrayOfErrorResponseMetadata < Dry::Struct

          attribute :ErrorResponseMetadata,    Types::Array.of(Fdsh::Vlp::H92::ErrorResponseMetadata).meta(omittable: false)
        end
      end
    end
  end
end