# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
          # Entity for Fdsh Vlp ErrorResponseMetadata
          class ErrorResponseMetadata < Dry::Struct

            attribute :ErrorResponseCode,                  Types::Strict::String.meta(omittable: false)
            attribute :ErrorResponseDescriptionText,       Types::Strict::String.meta(omittable: false)
            attribute :ErrorTDSResponseDescriptionText,    Types::String.optional.meta(omittable: true)

          end
        end
      end
    end
  end
end