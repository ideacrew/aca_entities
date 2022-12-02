# frozen_string_literal: true

module AcaEntities
  module Locations
    module Addresses
      module Contracts
        # Schema and validation rules for the {AcaEntities::Locations::Addresses::StreetAddress} entity
        class StreetAddressContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :id A unique identifier for this instance
          # @option opts [AcaEntities::Locations::Addresses::Types::AnyAddressKind] :kind Address type from enumerated list
          # @option opts [AcaEntities::Locations::Addresses::Types::StreetPredirectionKind] :street_predirection cardinal direction street prefix
          # @option opts [AcaEntities::Locations::Types::StringOrNil] :address_1 line 1 of street address
          # @option opts [AcaEntities::Locations::Types::StringOrNil] :address_2 line 2 of street address
          # @option opts [AcaEntities::Locations::Types::StringOrNil] :address_2 line 3 of street address
          # @option opts [AcaEntities::Locations::Addresses::Types::StreetPostdirectionKind] :street_postdirection cardinal direction street suffix
          # @option opts [String] :city_name town or city where this address is located
          # @option opts [AcaEntities::Types::UsStateAbbreviationKind] :state_abbreviation two character abbreviation for US state where this address is located
          # @option opts [String] :zip_code five character US Postal Service zip code
          # @option opts [String] :zip_plus_four_code four character US Postal Service zip-plus-four-code suffix
          # @option opts [AcaEntities::Locations::Types::StringOrNil] :county_name county or borough name where this address is located
          # @option opts [AcaEntities::Locations::Types::StringOrNil] :county_fips_code Three digit FIPS county code (US Census Bureau)
          # @option opts [AcaEntities::Locations::Types::StringOrNil] :state_fips_code Two digit FIPS state code (US Census Bureau)
          # @option opts [AcaEntities::Locations::Types::StringOrNil] :country_name country where this address is located
          # @option opts [AcaEntities::Locations::Types::StringOrNil] :country_code Three digit code country code
          # @option opts [AcaEntities::Locations::Contracts::GeographicCoordinates] :geographic_coordinates position of this address expressed as latitude and longitude
          # @option opts [AcaEntities::Locations::Addresses::Contracts::ValidationStatusContract] :validation_status when this address is verified by an address validation service, metadata from that validation response
          # @option opts [Boolean] :has_fixed_address Flag indicating whether party is homeless
          # @option opts [Boolean] :lives_outside_state_temporarily Flag indicating party is out of state on a temporary basis
          # @option opts [Date] :start_on Date when this address became active for the party
          # @option opts [Date] :end_on Date through which this address was active for the party
          # @option opts [Date] :timestamps metadata regarding creation and update times for this record
          # @return [Dry::Monads::Result::Success | Dry::Monads::Result::Failure] indicating if params pass validation
          params do
            optional(:id).value(:string)
            required(:kind).value(AcaEntities::Locations::Addresses::Types::AnyAddressKind)
            optional(:street_predirection).maybe(AcaEntities::Locations::Addresses::Types::StreetPredirectionKind)
            required(:address_1).value(:string)
            optional(:address_2).maybe(AcaEntities::Locations::Types::StringOrNil)
            optional(:address_3).maybe(AcaEntities::Locations::Types::StringOrNil)
            optional(:street_postdirection).maybe(AcaEntities::Locations::Addresses::Types::StreetPostdirectionKind)
            required(:city_name).value(:string)
            required(:state_abbreviation).value(AcaEntities::Types::UsStateAbbreviationKind)
            required(:zip_code).value(:string, size?: 5)
            optional(:zip_plus_four_code).maybe(:string, size?: 4)

            optional(:county_name).value(AcaEntities::Locations::Types::StringOrNil)
            optional(:county_fips_code).value(AcaEntities::Locations::Types::StringOrNil)
            optional(:state_fips_code).value(AcaEntities::Locations::Types::StringOrNil)

            optional(:country_name).value(AcaEntities::Locations::Types::StringOrNil)
            optional(:country_code).value(AcaEntities::Locations::Types::StringOrNil)

            optional(:geographic_coordinates).value(AcaEntities::Locations::Contracts::GeographicCoordinates.params)

            optional(:validation_status).maybe(
              AcaEntities::Locations::Addresses::Contracts::ValidationStatusContract.params
            )

            optional(:has_fixed_address).maybe(:bool)
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
