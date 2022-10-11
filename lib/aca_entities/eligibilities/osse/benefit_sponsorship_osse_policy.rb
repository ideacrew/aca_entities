# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    module Osse
      # Benefit Sponsorship Policy
      class BenefitSponsorshipOssePolicy < Dry::Struct
        # @!attribute [r] value
        # Value
        # @return [String]
        attribute :value, Types::String.meta(ommitable: false)
      end
    end
  end
end
