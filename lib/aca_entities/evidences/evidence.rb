# frozen_string_literal: true

module AcaEntities
  module Evidences
    # Entity for Evidence
    class Evidence < Dry::Struct

      attribute :key, Types::Symbol.meta(omittable: false)
      attribute :title, Types::String.meta(omittable: false)
      attribute :description, Types::String.optional.meta(omittable: true)
      attribute :eligibility_status, Types::String.meta(omittable: false)
      attribute :due_on, Types::Date.optional.meta(omittable: true)
      attribute :updated_by, Types::String.optional.meta(omittable: true)
      attribute :verification_status, AcaEntities::Evidences::VerificationStatus.optional.meta(omittable: true)
      attribute :verification_history, AcaEntities::Evidences::VerificationHistory.optional.meta(omittable: true)
      attribute :eligibility_results, Types::Array.of(AcaEntities::Evidences::EligibilityResult).optional.meta(omittable: true)
    end
  end
end
