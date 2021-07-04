# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp PassportCountryType
          class PassportCountryType < Dry::Struct

            attribute :passportNumber,         Types::Strict::String.meta(omittable: false)
            attribute :countryOfIssuance,      Types::Strict::String.meta(omittable: false)
          end
        end
      end
    end
  end
end