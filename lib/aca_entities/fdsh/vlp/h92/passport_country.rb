# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp PassportCountry
        class PassportCountry < Dry::Struct

          attribute :PassportNumber,         Types::Strict::String.meta(omittable: false)
          attribute :CountryOfIssuance,      Types::Strict::String.meta(omittable: false)
        end
      end
    end
  end
end