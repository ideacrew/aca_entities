# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp LocationStreet
      class LocationStreet < Dry::Struct

        attribute :street_full_text, Types::String.optional.meta(omittable: true)
      end
    end
  end
end