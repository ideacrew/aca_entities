# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for Sender information
      class Sender < Dry::Struct
        attribute :category_code,          Types::String.meta(omittable: false)
        attribute :state_code,           Types::String.optional.meta(omittable: true)
        attribute :county_name,          Types::String.optional.meta(omittable: true)
      end
    end
  end
end