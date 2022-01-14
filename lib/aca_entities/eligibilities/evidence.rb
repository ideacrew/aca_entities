# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # Entity for Evidence
    class Evidence < Dry::Struct

      attribute :key, Types::Symbol.meta(omittable: false)
      attribute :title, Types::String.meta(omittable: false)
      attribute :aasm_state, Types::String.meta(omittable: false)

      attribute :description, Types::String.optional.meta(omittable: true)
      attribute :received_at, Types::DateTime.optional.meta(omittable: true)

      attribute :is_satisfied, Types::Bool.optional.meta(omittable: true)
      attribute :verification_outstanding, Types::Bool.optional.meta(omittable: true)

      attribute :update_reason, Types::String.optional.meta(omittable: true)
      attribute :due_on, Types::Date.optional.meta(omittable: true)
      attribute :external_service, Types::String.optional.meta(omittable: true)
      attribute :updated_by, Types::String.optional.meta(omittable: true)

      attribute :verification_histories, Types::Array.of(AcaEntities::Eligibilities::VerificationHistory).optional.meta(omittable: true)
      attribute :request_results, Types::Array.of(AcaEntities::Eligibilities::RequestResult).optional.meta(omittable: true)

    end
  end
end
