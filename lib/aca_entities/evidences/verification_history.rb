# frozen_string_literal: true

module AcaEntities
  module Evidences
    # Entity for VerificationHistory
    class VerificationHistory < Dry::Struct
      attribute :action, Types::String.optional.meta(omittable: true)
      attribute :modifier, Types::String.optional.meta(omittable: true)
      attribute :update_reason, Types::String.optional.meta(omittable: true)
    end
  end
end
