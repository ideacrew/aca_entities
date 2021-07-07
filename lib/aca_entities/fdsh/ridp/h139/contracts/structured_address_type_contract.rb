# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for StructuredAddressType
        class StructuredAddressTypeContract < Dry::Validation::Contract
          params do
            optional(:location_street).maybe(:string)
            optional(:location_city_name).maybe(:string)
            optional(:location_state_uspostal_service_code).maybe(
              AcaEntities::Types::UsStateAbbreviationKind
            )
            optional(:location_postal_code).maybe(:string)
          end
        end
      end
    end
  end
end
