# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp TempI551DocumentId
        class TempI551DocumentId < Dry::Struct

          attribute :AlienNumber,         Types::Strict::String.meta(omittable: false)
          attribute :PassportCountry,     Fdsh::Vlp::H92::PassportCountry.optional.meta(omittable: true)
          attribute :DocExpirationDate,   Types::Date.optional.meta(omittable: true)
        end
      end
    end
  end
end
