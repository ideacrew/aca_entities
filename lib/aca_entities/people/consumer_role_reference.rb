# frozen_string_literal: true

module AcaEntities
  module People
    class ConsumerRoleReference < Dry::Struct

      attribute :is_active, Types::Bool.optional.meta(omittable: true)
      attribute :is_applying_coverage, Types::Bool.optional.meta(omittable: false)
      attribute :is_applicant, Types::Bool.optional.meta(omittable: false)
      attribute :is_state_resident, Types::Bool.optional.meta(omittable: false)
      attribute :lawful_presence_determination, AcaEntities::Determinations::LawfulPresenceDetermination.optional.meta(omittable: false)
      attribute :citizen_status, Types::String.optional.meta(omittable: true)
    end
  end
end