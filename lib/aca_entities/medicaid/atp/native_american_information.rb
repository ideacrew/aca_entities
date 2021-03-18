# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp NativeAmericanInformation
      class NativeAmericanInformation < Dry::Struct

        attribute :is_native_american_or_alaska_native, Types::Bool
        attribute :indian_tribe_state_code, Types::String.optional.meta(omittable: true)
        attribute :federally_recognized_tribe, Types::Bool.optional.meta(omittable: true)
        attribute :tribe_name, Types::String.optional.meta(omittable: true)
        attribute :itu_eligible, Types::Bool.optional.meta(omittable: true)
        attribute :received_ihs, Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
