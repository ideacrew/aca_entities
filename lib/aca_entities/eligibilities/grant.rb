# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A grant can be cost sharing grant, employer contribution grant
    # or osse premium credit
    class Grant < Dry::Struct
      # @!attribute [r] premium_adjustment_grant
      # Type of grant, for example cost sharing grant, employer contribution grant
      # or osse premium credit
      # @return [String]
      attribute :premium_adjustment_grant,
                AcaEntities::Eligibilities::Types::PremiumAdjustmentGrantType.meta(
                  ommittable: false
                )

      # @!attribute [r] value
      # Value can be csr, aptc or employer contribution
      # csr is a percentage, aptc is a $ amount, employer contribution, enrollment ratio
      # @return [Float]
      attribute :value, Types::Float.optional.meta(ommitable: false)

      # @!attribute [r] start_on
      # Start date for the grant
      # @return [Date]
      attribute :start_on, Types::Date.meta(omittable: false)

      # @!attribute [r] end_on
      # End date for the grant
      # @return [Date]
      attribute :end_on, Types::Date.meta(omittable: false)
    end
  end
end
