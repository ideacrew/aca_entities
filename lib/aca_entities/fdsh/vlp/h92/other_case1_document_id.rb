# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp OtherCase1DocumentId
        class OtherCase1DocumentId < Dry::Struct

          attribute :AlienNumber,         Types::Strict::String.meta(omittable: false)
          attribute :PassportCountry,     Fdsh::Vlp::H92::PassportCountry.optional.meta(omittable: true)
          attribute :DocExpirationDate,   Types::Date.optional.meta(omittable: true)
          attribute :DocDescReq,          Types::Strict::String.meta(omittable: false)
        end
      end
    end
  end
end