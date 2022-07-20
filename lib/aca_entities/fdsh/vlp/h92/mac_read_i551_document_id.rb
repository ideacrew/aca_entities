# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp MacReadI551DocumentId
        class MacReadI551DocumentId < Dry::Struct

          attribute :AlienNumber,         Types::Strict::String.meta(omittable: false)
          attribute :VisaNumber,          Types::String.optional.meta(omittable: true)
          attribute :PassportNumber,      Types::Strict::String.meta(omittable: false)
          attribute :CountryOfIssuance,   Types::Strict::String.meta(omittable: false)
          attribute :DocExpirationDate,   Types::Date.optional.meta(omittable: true)
        end
      end
    end
  end
end