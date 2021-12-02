# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp PersonEthnicityText
      class PersonEthnicityText < Dry::Struct
        attribute :value, Types::String.optional.meta(omittable: true)
      end
    end
  end
end