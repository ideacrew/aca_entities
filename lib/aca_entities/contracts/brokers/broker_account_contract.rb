# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Brokers
      # Schema and validation rules for {AcaEntities::Brokers::BrokerAccount}
      class BrokerAccountContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :start_on required
        # @option opts [Date] :end_on optional
        # @option opts [Boolean] :is_active required
        # @option opts [Hash] :broker_role required
        # @option opts [Hash] :broker_agency required
        # @option opts [Hash] :updated_by optional
        # @return [Dry::Monads::Result]
        params do
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          required(:is_active).maybe(:bool)
          required(:broker_role_reference).hash(AcaEntities::Contracts::Brokers::BrokerRoleReferenceContract.params)
          required(:broker_agency_reference).hash(AcaEntities::Contracts::Organizations::BrokerAgencyProfileReferenceContract.params)
          optional(:updated_by).hash(AcaEntities::Contracts::People::PersonReferenceContract.params)
        end
      end
    end
  end
end


