# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Locations
    module Smarty
      # Custom type definitions supporting SmartyStreets Ruby SDK
      module Types
        send(:include, Dry.Types)

        # strict: The API will return detailed output only if a valid
        #   match is found. Otherwise the API response will be an empty array.
        # invalid: The API will return detailed output for both
        #   valid and invalid addresses. To find out if the address is valid,
        #   check the dpv_match_code. Values of Y, S, or D indicate a valid address.
        # enhanced: The API will return detailed output based on a more
        #   aggressive matching mechanism. It also includes a more comprehensive
        #   address dataset beyond just the postal address data. Requires a
        #   US Core license or a US Rooftop Geocoding license. Note: A freeform
        #   address, that we can't find a match for, will respond with an empty array, "[]".
        AddressMatchKind = Types::Coercible::String.enum('strict', 'invalid', 'enhanced').freeze
      end
    end
  end
end
