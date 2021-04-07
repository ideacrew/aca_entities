# frozen_string_literal: true

module AcaEntities
  module Contracts
    module BenefitCatalogs
      # Schema and validation rules for {AcaEntities::BenefitCatalogs::BenefitCoveragePeriodReference}
      class BenefitCoveragePeriodReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :title required
        # @option opts [String] :market_place required
        # @option opts [String] :start_on required
        # @option opts [String] :end_on required
        # @option opts [String] :open_enrollment_start_on required
        # @option opts [String] :open_enrollment_end_on required
        # @return [Dry::Monads::Result]
        params do
          required(:title).filled(:string)
          required(:market_place).filled(
            AcaEntities::Types::ServiceMarketKinds
          )
          required(:start_on).filled(:date)
          required(:end_on).filled(:date)
          required(:open_enrollment_start_on).filled(:date)
          required(:open_enrollment_end_on).filled(:date)
        end

        rule(:end_on, :start_on) do
          if values[:end_on]
            key.failure('end on must be after start on') if values[:end_on] < values[:start_on]
          end
        end

        rule(:open_enrollment_end_on, :open_enrollment_start_on) do
          if values[:open_enrollment_end_on]
            key.failure('open enrollment_end_on must be after open_enrollment_start_on') if values[:open_enrollment_end_on] < values[:open_enrollment_start_on]
          end
        end
      end
    end
  end
end