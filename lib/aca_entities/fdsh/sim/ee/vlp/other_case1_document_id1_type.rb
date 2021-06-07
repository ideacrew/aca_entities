# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp OtherCase1DocumentID1Type
          class OtherCase1DocumentID1Type < Dry::Struct

            attribute :alienNumber,         Types::Strict::String.meta(omittable: false)
            attribute :passportCountry,     Fdsh::Sim::Ee::Vlp::PassportCountryType.meta(omittable: true)
            attribute :sevisid,             Types::Strict::String.meta(omittable: true)
            attribute :docDescReq,          Types::Strict::String.meta(omittable: false)
            attribute :docExpirationDate,   Types::Strict::Date.meta(omittable: true)
          end
        end
      end
    end
  end
end