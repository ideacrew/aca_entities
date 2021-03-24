# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    class Relationship < Dry::Struct
      attribute :kind, Types::String
      attribute :applicant_id, Types::String
      attribute :relative_id, Types::String

      # Applicant's same_with_primary maps to this.
      attribute :lives_with_household_member, Types::Bool.optional.meta(omittable: true)
    end
  end
end