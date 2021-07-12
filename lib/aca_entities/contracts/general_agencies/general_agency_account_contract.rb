# frozen_string_literal: true

module AcaEntities
  module Contracts
    module GeneralAgencies
      # Schema and validation rules for {AcaEntities::GeneralAgencies::GeneralAgencyAccount}
      class GeneralAgencyAccountContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :start_on required
        # @option opts [Date] :end_on optional
        # @option opts [Boolean] :is_active optional
        # @option opts [Boolean] :aasm_state optional
        # @option opts [Hash] :broker_role required
        # @option opts [Hash] :general_agency_profile required
        # @option opts [Hash] :updated_by optional
        # @return [Dry::Monads::Result]
        params do
          required(:start_on).value(:date)
          optional(:end_on).value(:date)
          optional(:is_active).maybe(:bool)
          optional(:aasm_state).maybe(AcaEntities::Types::GaState)
          required(:broker_role_reference).hash(AcaEntities::Contracts::Brokers::BrokerRoleReferenceContract.params)
          required(:general_agency_reference).hash(AcaEntities::Contracts::Organizations::GeneralAgencyReferenceContract.params)
          optional(:updated_by).hash(AcaEntities::Contracts::People::PersonReferenceContract.params)
        end
      end
    end
  end
end
