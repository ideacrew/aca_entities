# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp I20DocumentId26Type
          class I20DocumentId26Type < Dry::Struct

            attribute :i94Number,           Types::Strict::String.meta(omittable: true)
            attribute :passportCountry,     Fdsh::Sim::Ee::Vlp::PassportCountryType.meta(omittable: true)
            attribute :sevisid,             Types::Strict::String.meta(omittable: false)
            attribute :docExpirationDate,   Types::Strict::Date.meta(omittable: true)
          end
        end
      end
    end
  end
end