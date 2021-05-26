# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Ds2019DocumentId27Type
          class Ds2019DocumentId27Type < Dry::Struct

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