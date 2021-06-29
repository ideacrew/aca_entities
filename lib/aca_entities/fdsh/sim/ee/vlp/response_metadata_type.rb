# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp ResponseMetadataType
          class ResponseMetadataType < Dry::Struct

            attribute :responseCode,                  Types::Strict::String.meta(omittable: false)
            attribute :responseDescriptionText,       Types::Strict::String.meta(omittable: false)
            attribute :tdsResponseDescriptionText,    Types::Strict::String.meta(omittable: true)
          end
        end
      end
    end
  end
end