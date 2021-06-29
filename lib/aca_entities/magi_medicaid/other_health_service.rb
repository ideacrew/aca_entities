# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Canonical Vocabulary Entity for MAGI Medicaid OtherHealthService.
    # OtherHealthServices - Indian Health Service, Tribal health program,
    # Urban Indian health program, and Referral
    class OtherHealthService < Dry::Struct
      # @!attribute [r] has_received
      # Has this person ever gotten a health service from the Indian Health Service,
      # a tribal health program, or urban Indian health program or
      # through a referral from one of these programs?
      # @return [Bool]
      attribute :has_received, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] is_eligible
      # Is this person eligible to get health services from the Indian Health Service,
      # a tribal health program, or an urban Indian health program or
      # through referral from one of these programs?
      # @return [Bool]
      attribute :is_eligible, Types::Bool.optional.meta(omittable: true)
    end
  end
end
