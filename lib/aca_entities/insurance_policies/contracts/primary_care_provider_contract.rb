# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::PrimaryCareProvider} entity
      class PrimaryCareProviderContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:health_care_practitioner).value(
            AcaEntities::InsurancePolicies::Contracts::HealthCarePractitionerContract.params
          )
          required(:begin_on).value(:date)
          required(:end_on).value(:date)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
