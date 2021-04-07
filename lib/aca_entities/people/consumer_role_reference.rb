# frozen_string_literal: true

module AcaEntities
  module People
    class ConsumerRoleReference < Dry::Struct

      attribute :is_active, Types::Strict::Bool.optional.meta(omittable: false)
      attribute :is_applying_coverage, Types::Strict::Bool.optional.meta(omittable: false)
      attribute :is_applicant, Types::Strict::Bool.optional.meta(omittable: false)
      attribute :is_state_resident, Types::Strict::Bool.optional.meta(omittable: false)
      attribute :lawful_presence_determination, AcaEntities::Determination::LawfulPresenceDetermination.optional.meta(omittable: false)
      attribute :citizen_status, Types::Strict::String.optional.meta(omittable: false)
    end
  end
end