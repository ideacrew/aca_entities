# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp I20DocumentId
        class I20DocumentId < Dry::Struct

          attribute :I94Number,           Types::String.optional.meta(omittable: true)
          attribute :PassportCountry,     Fdsh::Vlp::H92::PassportCountry.optional.meta(omittable: true)
          attribute :SEVISID,             Types::Strict::String.meta(omittable: false)
          attribute :DocExpirationDate,   Types::Date.optional.meta(omittable: true)
        end
      end
    end
  end
end