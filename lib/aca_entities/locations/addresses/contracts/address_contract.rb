# frozen_string_literal: true

module AcaEntities
  module Locations
    module Addresses
      module Contracts
        # Schema and validation rules for the {AcaEntities::InsurancePolicies::Enrollment} entity
        class AddressContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id).value(:string)
            optional(:has_fixed_address).maybe(:bool)
            required(:kind).value(AcaEntities::Locations::Types::AnyAddressKind)
            required(:address_1).value(:string)
            optional(:address_2).maybe(AcaEntities::Locations::Types::StringOrNil)
            optional(:address_3).maybe(AcaEntities::Locations::Types::StringOrNil)
            required(:city).value(:string)
            required(:state).value(AcaEntities::Types::UsStateAbbreviationKind)
            required(:zip).value(:string, size?: 5)

            optional(:county).value(AcaEntities::Locations::Types::StringOrNil)
            optional(:county_code).value(AcaEntities::Locations::Types::StringOrNil)

            optional(:country_code).value(AcaEntities::Locations::Types::StringOrNil)
            optional(:country_name).value(AcaEntities::Locations::Types::StringOrNil)

            optional(:geocode).value(AcaEntities::Locations::Types::StringOrNil)

            optional(:validation_status).maybe(
              AcaEntities::Locations::Addresses::Contracts::ValidationStatusContract.params
            )

            optional(:lives_outside_state_temporarily).maybe(:bool)

            optional(:start_on).maybe(:date)
            optional(:end_on).maybe(:date)
            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end
