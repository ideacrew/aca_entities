# frozen_string_literal: true

module AcaEntities
  module Locations
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::Enrollment} entity
      class SiteAddressContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:kind).value(AcaEntities::Types::AddressKinds)
          required(:address_1).value(:string)
          optional(:address_2).value(AcaEntities::Types::StringOrNil)
          optional(:address_3).value(AcaEntities::Types::StringOrNil)
          required(:city).value(:string)
          required(:state_abbreviation).value(AcaEntities::Types::UsStateAbbreviationKind)
          required(:zip_code).value(:string)
          optional(:zip_plus_four).value(AcaEntities::Types::StringOrNil)
          optional(:full_address).value(AcaEntities::Types::StringOrNil)
          optional(:county_name).value(AcaEntities::Types::StringOrNil)
          optional(:county_fips_code).value(AcaEntities::Types::StringOrNil)
          optional(:state_fips_code).value(AcaEntities::Types::StringOrNil)
          optional(:country_name).value(AcaEntities::Types::StringOrNil)
          optional(:country_code).value(AcaEntities::Types::StringOrNil)
          optional(:validation_status).maybe(AcaEntities::Locations::Contracts::AddressValidationStatusContract.params)
          optional(:start_on).maybe(:date)
          optional(:end_on).maybe(:date)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
