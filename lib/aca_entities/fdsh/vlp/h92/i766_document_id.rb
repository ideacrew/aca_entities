# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp I766DocumentId
        class I766DocumentId < Dry::Struct

          attribute :AlienNumber,         Types::String.optional.meta(omittable: true)
          attribute :ReceiptNumber,       Types::Strict::String.meta(omittable: false)
          attribute :DocExpirationDate,   Types::Date.optional.meta(omittable: true)
        end
      end
    end
  end
end