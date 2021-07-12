# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PersonName
      class PersonName < Dry::Struct

        attribute :given, Types::String.meta(omittable: false)
        attribute :middle, Types::String.optional.meta(omittable: true)
        attribute :sur, Types::String.meta(omittable: false)
        attribute :suffix, Types::String.optional.meta(omittable: true)
        attribute :prefix, Types::String.optional.meta(omittable: true)
        attribute :full, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
