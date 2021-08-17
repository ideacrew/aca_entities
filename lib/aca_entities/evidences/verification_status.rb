# frozen_string_literal: true

module AcaEntities
  module Evidences
    # Entity for VerificationStatus
    class VerificationStatus < Dry::Struct

      attribute :status, Types::String.optional.meta(omittable: true)
      attribute :title, Types::String.optional.meta(omittable: true)
      attribute :description, Types::String.optional.meta(omittable: true)
      attribute :due_on, Types::String.optional.meta(omittable: true)
      attribute :updated_by, Types::String.optional.meta(omittable: true)
      attribute :assigned_to, Types::String.optional.meta(omittable: true)
      attribute :documents, Types::Array.of(AcaEntities::Documents::Document).optional.meta(omittable: true)
      # attribute :transitions
    end
  end
end
