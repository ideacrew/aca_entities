# frozen_string_literal: true

require 'aca_entities/atp/types'

module AcaEntities
  module Atp
    module Transformers
      module Cv
        # Transformers implementation for atp payloads
        class ContactInfo < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          add_key 'kind', value: "work"

          map 'location_street.street_full_text', 'address_1'
          map 'address_secondary_unit_text', 'address_2'
          map 'earned_date_range.start_date.date', 'start_on'
          map 'location_county_name', 'county'
          map 'location_city_name', 'city'
          map 'location_state_us_postal_service_code', 'state'
          map 'location_postal_code', 'zip'

          map 'telephone.telephone_number_full_id', 'full_phone_number'

        end
      end
    end
  end
end
