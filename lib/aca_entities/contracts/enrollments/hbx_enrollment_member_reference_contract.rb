# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Enrollments
      # Schema and validation rules for {AcaEntities::Enrollments::HbxEnrollmentMemberReference}
      class HbxEnrollmentMemberReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :is_subscriber required
        # @option opts [Hash] :premium_amount optional
        # @option opts [Hash] :applied_aptc_amount optional
        # @option opts [Date] :eligibility_date required
        # @option opts [Date] :coverage_start_on required
        # @option opts [Date] :coverage_end_on optional
        # @option opts [String] :tobacco_use optional
        # @return [Dry::Monads::Result]
        params do
          required(:is_subscriber).maybe(:boolean)
          optional(:premium_amount).hash(AcaEntities::Contracts::CurrencyContract.params)
          optional(:applied_aptc_amount).hash(AcaEntities::Contracts::CurrencyContract.params)
          required(:eligibility_date).maybe(:date)
          required(:coverage_start_on).maybe(:date)
          optional(:coverage_end_on).maybe(:date)
          optional(:tobacco_use).maybe(:string)
        end
      end
    end
  end
end
