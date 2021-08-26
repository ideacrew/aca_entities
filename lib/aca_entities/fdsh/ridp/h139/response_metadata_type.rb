# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for ResponseMetadataType
        class ResponseMetadataType < Dry::Struct

          attribute :response_code,                   Types::String.meta(omittable: false)
          attribute :response_description_text,       Types::String.meta(omittable: false)
          attribute :tds_response_description_text,   Types::String.optional.meta(omittable: true)

        end
      end
    end
  end
end