# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp SignatureName
      class SignatureName < Dry::Struct

        attribute :given, Types::String.optional.meta(omittable: true)
        attribute :middle, Types::String.optional.meta(omittable: true)
        attribute :sur, Types::String.optional.meta(omittable: true)
        attribute :suffix, Types::String.optional.meta(omittable: true)
        attribute :full, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
