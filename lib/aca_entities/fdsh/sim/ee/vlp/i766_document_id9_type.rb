# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp I766DocumentID9Type
          class I766DocumentID9Type < Dry::Struct

            attribute :alienNumber,         Types::Strict::String.meta(omittable: true)
            attribute :receiptNumber,       Types::Strict::String.meta(omittable: false)
            attribute :docExpirationDate,   Types::Strict::Date.meta(omittable: true)
          end
        end
      end
    end
  end
end