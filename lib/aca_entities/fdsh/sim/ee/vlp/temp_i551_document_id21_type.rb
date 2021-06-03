# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp TempI551DocumentID21Type
          class TempI551DocumentID21Type < Dry::Struct

            attribute :alienNumber,         Types::Strict::String.meta(omittable: false)
            attribute :passportCountry,     Types::Strict::String.meta(omittable: false)
            attribute :docExpirationDate,   Types::Strict::Date.meta(omittable: true)
          end
        end
      end
    end
  end
end