# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp I571DocumentID5Type
          class I571DocumentID5Type < Dry::Struct

            attribute :alienNumber,         Types::Strict::String.meta(omittable: true)
            attribute :docExpirationDate,   Types::Strict::Date.meta(omittable: true)
          end
        end
      end
    end
  end
end