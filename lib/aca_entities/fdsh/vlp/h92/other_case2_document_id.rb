# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp OtherCase2DocumentId
        class OtherCase2DocumentId < Dry::Struct

          attribute :I94Number,           Types::String.meta(omittable: false)
          attribute :PassportCountry,     Fdsh::Vlp::H92::PassportCountry.optional.meta(omittable: true)
          attribute :SEVISID,             Types::String.optional.meta(omittable: true)
          attribute :DocExpirationDate,   Types::Date.optional.meta(omittable: true)
          attribute :DocDescReq,          Types::Strict::String.meta(omittable: false)
        end
      end
    end
  end
end