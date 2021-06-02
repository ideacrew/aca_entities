# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      # Entity for FarsRequest
      class FarsRequest < Dry::Struct

        attribute :dSH_reference_number,          Types::String.meta(omittable: false)
        attribute :subscriber_number,             Types::Integer.meta(omittable: false)

      end
    end
  end
end