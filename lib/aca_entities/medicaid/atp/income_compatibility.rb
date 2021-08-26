# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp IncomeCompatibility
      class IncomeCompatibility < Dry::Struct

        attribute :verification_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :inconsistency_reason_text, Types::String.optional.meta(omittable: true)
        attribute :compatibility_determination, IncomeCompatibilityDetermination.optional.meta(omittable: true)
        attribute :verification_method, Types::String.optional.meta(omittable: true)
      end
    end
  end
end