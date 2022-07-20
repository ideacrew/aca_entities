# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp I571DocumentId
        class I571DocumentId < Dry::Struct

          attribute :AlienNumber,         Types::String.optional.meta(omittable: true)
          attribute :DocExpirationDate,   Types::Date.optional.meta(omittable: true)
        end
      end
    end
  end
end