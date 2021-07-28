# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp I94DocumentId
        class I94DocumentId < Dry::Struct

          attribute :I94Number,           Types::Strict::String.meta(omittable: false)
          attribute :SEVISID,             Types::String.optional.meta(omittable: true)
          attribute :DocExpirationDate,   Types::Date.optional.meta(omittable: true)
        end
      end
    end
  end
end