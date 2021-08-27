# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Employment < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          add_key 'begin_date', value: ->(_v) { { date: Date.today }} # default
          add_key 'end_date', value: ->(_v) { { date: Date.today }} # default
          map 'employer.employer_id', 'employer.id'
          map 'employer.employer_name', 'employer.category_text'
          add_key 'organization_primary_contact_information.email_id'
          map 'address_1', 'organization_primary_contact_information.mailing_address.address.location_street.street_full_text'
          map 'address_2', 'organization_primary_contact_information.mailing_address.address.address_secondary_unit_text'
          map 'city', 'organization_primary_contact_information.mailing_address.address.location_city_name'
          map 'county', 'organization_primary_contact_information.mailing_address.address.location_county_name'
          map 'state', 'organization_primary_contact_information.mailing_address.address.location_state_us_postal_service_code'
          map 'zip', 'organization_primary_contact_information.mailing_address.address.location_postal_code'
          map 'employer_phone', 'organization_primary_contact_information.mailing_address.telephone_number'
        end
      end
    end
  end
end