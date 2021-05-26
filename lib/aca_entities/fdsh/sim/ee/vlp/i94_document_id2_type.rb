# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp I94DocumentID2Type
          class I94DocumentID2Type < Dry::Struct

            attribute :i94Number,           Types::Strict::String.meta(omittable: false)
            attribute :sevisid,             Types::Strict::String.meta(omittable: true)
            attribute :docExpirationDate,   Types::Strict::Date.meta(omittable: true)
          end
        end
      end
    end
  end
end