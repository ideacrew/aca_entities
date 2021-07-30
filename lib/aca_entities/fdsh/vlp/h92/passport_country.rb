# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp PassportCountry
        class PassportCountry < Dry::Struct

          attribute :PassportNumber,         Types::String.optional.meta(omittable: false)
          attribute :CountryOfIssuance,      Types::String.optional.meta(omittable: false)
        end
      end
    end
  end
end