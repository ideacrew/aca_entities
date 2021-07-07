# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for StructuredAddress.
      class StructuredAddressContract < Dry::Validation::Contract

        params do
          optional(:location_street).maybe(:hash)
          optional(:address_secondary_unit_text).maybe(:string)
          optional(:location_city_name).maybe(:string)
          optional(:location_county_name).maybe(:string)
          optional(:location_county_code).maybe(:string)
          optional(:location_state_us_postal_service_code).maybe(:string)
          optional(:location_postal_code).maybe(:string)
        end
      end
    end
  end
end