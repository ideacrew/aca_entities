# frozen_string_literal: true

module AcaEntities
  module AptcCsrEligibilitiesEnrollments
    class AptcAccumulator < Dry::Struct
      attribute :maximum_amount, AcaEntities::Types::Money.meta(omittable: false)
      attribute :balance, AcaEntities::Types::Money.meta(omittable: false)
      attribute :accumulator_adjustments, Types::Array.of(AccumulatorAdjustment).optional.meta(omittable: true)

      # def initialize(args)
      #   args.merge!(
      #     balance: calculate_balance(args[:accumulator_adjustments])
      #   )
      #   super(args)
      # end

      # def calculate_balance(accumulator_adjustments_params)
      #   # Below are params. Array of Hashes
      #   accumulator_adjustments_params.each do |adjustment|
      #   end
      # end
    end
  end
end