# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module CloseCase
          # Entity for Fdsh Vlp ResponseMetadata
          class ResponseMetadata < Dry::Struct

            attribute :ResponseCode,                  Types::Strict::String.meta(omittable: false)
            attribute :ResponseDescriptionText,       Types::Strict::String.meta(omittable: false)
            attribute :TdsResponseDescriptionText,    Types::String.optional.meta(omittable: true)

          end
        end
      end
    end
  end
end