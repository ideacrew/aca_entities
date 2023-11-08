# frozen_string_literal: true

module AcaEntities
  module People
    class ResidentRoleReference < Dry::Struct
      attribute :is_applicant, Types::Bool.optional.meta(omittable: true)
      attribute :is_active, Types::Bool.optional.meta(omittable: false)
      attribute :is_state_resident, Types::Bool.optional.meta(omittable: false)
      attribute :residency_determined_at, Types::Date.optional.meta(omittable: true)
    end
  end
end