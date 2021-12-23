# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # Entity for VerificationHistory
    class VerificationHistory < Dry::Struct
      attribute :action, Types::String.optional.meta(omittable: true)
      attribute :modifier, Types::String.optional.meta(omittable: true)
      attribute :update_reason, Types::String.optional.meta(omittable: true)
      attribute :updated_by, Types::String.optional.meta(omittable: true)
      attribute :is_satisfied, Types::Bool.optional.meta(omittable: true)
      attribute :verification_outstanding, Types::Bool.optional.meta(omittable: true)
      attribute :due_on, Types::Date.optional.meta(omittable: true)
      attribute :aasm_state, Types::String.optional.meta(omittable: true)
    end
  end
end
