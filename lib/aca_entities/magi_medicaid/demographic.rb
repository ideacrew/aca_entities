# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for Demographic.
    class Demographic < Dry::Struct

      attribute :gender, Types::GenderKind.meta(omittable: false)
      attribute :dob, Types::Date.meta(omittable: false)
      # Do not allow nil for ethnicity
      attribute :ethnicity, Types::Array.of(Types::String).meta(omittable: true)
      attribute :race, Types::String.optional.meta(omittable: true)
      attribute :is_veteran_or_active_military, Types::Bool.optional.meta(omittable: true)
      attribute :is_vets_spouse_or_child, Types::Bool.optional.meta(omittable: true)
    end
  end
end
