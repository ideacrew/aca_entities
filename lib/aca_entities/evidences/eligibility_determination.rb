# frozen_string_literal: true

module AcaEntities
  module Evidences
    # Entity for VerificationHistory
    class EligibilityDetermination < Dry::Struct
      attribute :result, Types::Symbol.meta(omittable: false)
      attribute :source, Types::String.meta(omittable: false)
      attribute :source_transaction_id, Types::String.meta(omittable: false)
      attribute :code, Types::String.optional.meta(omittable: true)
      attribute :code_description, AcaEntities::CodeDescription.optional.meta(omittable: true)
    end
  end
end
