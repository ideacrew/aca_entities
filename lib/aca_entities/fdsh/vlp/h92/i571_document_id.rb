# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp I571DocumentId
        class I571DocumentId < Dry::Struct

          attribute :AlienNumber,         Types::Strict::String.meta(omittable: true)
          attribute :DocExpirationDate,   Types::Strict::Date.meta(omittable: true)
        end
      end
    end
  end
end