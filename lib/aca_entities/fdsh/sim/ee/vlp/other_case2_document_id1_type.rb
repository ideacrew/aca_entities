# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp OtherCase2DocumentID1Type
          class OtherCase2DocumentID1Type < Dry::Struct

            attribute :i94Number,           Types::Strict::String.meta(omittable: false)
            attribute :passportCountry,     Fdsh::Sim::Ee::Vlp::PassportCountryType.meta(omittable: true)
            attribute :sevisid,             Types::Strict::String.meta(omittable: true)
            attribute :docExpirationDate,   Types::Strict::Date.meta(omittable: true)
            attribute :docDescReq,          Types::Strict::String.meta(omittable: false)s
          end
        end
      end
    end
  end
end