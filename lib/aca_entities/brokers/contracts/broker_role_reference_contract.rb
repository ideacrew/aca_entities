# frozen_string_literal: true

module AcaEntities
  module Brokers
    module Contracts
      # Schema and validation rules for {AcaEntities::Brokers::BrokerRoleReference}
      class BrokerRoleReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :npn required
        # @option opts [Hash] :person required
        # @option opts [Hash] :broker_agency required
        # @return [Dry::Monads::Result]
        params do
          required(:npn).filled(:string)
          required(:person_reference).filled(AcaEntities::People::Contracts::PersonReferenceContract.params)
          required(:broker_agency_reference).hash(
            AcaEntities::Organizations::Contracts::BrokerAgencyProfileReferenceContract.params
          )
        end
      end
    end
  end
end
