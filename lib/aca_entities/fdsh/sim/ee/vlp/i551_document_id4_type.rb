# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp I551DocumentID4Type
          class I551DocumentID4Type < Dry::Struct

            attribute :alienNumber,         Types::Strict::String.meta(omittable: false)
            attribute :receiptNumber,       Types::Strict::String.meta(omittable: false)
            attribute :docExpirationDate,   Types::Strict::Date.meta(omittable: true)
          end
        end
      end
    end
  end
end