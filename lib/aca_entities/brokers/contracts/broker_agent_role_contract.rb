#  frozen_string_literal: true

module AcaEntities
  module Brokers
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::InsuranceProvider} entity
      class BrokerAgentRoleContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)

          required(:npn_id).filled(:string)
          required(:aasm_state).filled(:string)
          required(:person_name).filled(AcaEntities::Contracts::People::PersonNameContract.params)
          required(:serving_marketplaces).array(AcaEntities::Types::AcaMarketplaceKind)
          optional(:spoken_languages).array(:string)
          optional(:working_hours).value(AcaEntities::TimePeriods::Contracts::WorkingHours.params)

          # TODO: Determine definition and improve these attributes' names
          optional(:reason).array(:string)
          optional(:provider_kind).array(Types::ProviderKinds)
          optional(:accepts_new_clients).value(:bool)
          optional(:license).value(:bool)
          optional(:training).value(:bool)

          # TODO: Change data type from hash to defined contract
          optional(:carrier_appointments).value(:hash)

          # TODO: BrokerAgency should reference.  Remove from this model
          optional(:broker_agency_reference).value(
            AcaEntities::Organizations::Contracts::BrokerAgencyProfileReferenceContract.params
          )

          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
