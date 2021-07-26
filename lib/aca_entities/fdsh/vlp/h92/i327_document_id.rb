# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp I327DocumentID
        class I327DocumentId < Dry::Struct

          attribute :AlienNumber,         Types::Strict::String.meta(omittable: false)
          attribute :DocExpirationDate,   Types::Date.optional.meta(omittable: true)
        end
      end
    end
  end
end