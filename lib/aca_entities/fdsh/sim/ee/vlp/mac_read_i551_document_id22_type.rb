# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp MacReadI551DocumentID22Type
          class MacReadI551DocumentID22Type < Dry::Struct

            attribute :alienNumber,         Types::Strict::String.meta(omittable: false)
            attribute :visaNumber,          Types::Strict::String.meta(omittable: true)
            attribute :passportNumber,      Types::Strict::String.meta(omittable: false)
            attribute :countryOfIssuance,   Types::Strict::String.meta(omittable: false)
            attribute :docExpirationDate,   Types::Strict::Date.meta(omittable: true)
          end
        end
      end
    end
  end
end