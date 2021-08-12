# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for NativeAmericanInformation.
    class NativeAmericanInformation < Dry::Struct
      attribute :indian_tribe_member, Types::Bool.optional.meta(omittable: true)
      attribute :tribal_id, Types::String.optional.meta(omittable: true)
      attribute :tribal_name, Types::String.optional.meta(omittable: true)
      attribute :tribal_state, Types::String.optional.meta(omittable: true)
    end
  end
end
