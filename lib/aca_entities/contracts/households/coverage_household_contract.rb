# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::CoverageHousehold}
      class CoverageHouseholdContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :start_date optional
        # @option opts [Date] :end_date optional
        # @option opts [Boolean] :is_immediate_family required
        # @option opts [Boolean] :is_determination_split_household optional
        # @option opts [String] :aasm_state optional
        # @option opts [Date] :submitted_at optional
        # @option opts [Hash] :coverage_household_members required
        # @option opts [Hash] :broker_agency optional
        # @option opts [Hash] :broker_role optional
        # @return [Dry::Monads::Result]
        params do
          optional(:start_date).value(:date?)
          optional(:end_date).value(:date?)
          required(:is_immediate_family).filled(:bool)
          optional(:is_determination_split_household).maybe(:bool)
          optional(:aasm_state).maybe(:string)
          optional(:submitted_at).maybe(:date)
          required(:coverage_household_members).array(AcaEntities::Contracts::Households::CoverageHouseholdMemberContract.params)
          optional(:broker_role_reference).hash(AcaEntities::Contracts::Brokers::BrokerRoleReferenceContract.params)
          optional(:broker_agency_reference).hash(AcaEntities::Contracts::Organizations::BrokerAgencyProfileReferenceContract.params)
        end
      end
    end
  end
end





