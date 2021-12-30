# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Address < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          add_key 'begin_date', value: ->(_v) { Date.today } # default
          add_key 'end_date', value: ->(_v) { Date.today } # default
          add_key 'email_id'
          map 'address_1', 'contact.mailing_address.address.location_street.street_full_text'
          map 'address_2', 'contact.mailing_address.address.address_secondary_unit_text', function: lambda { |v|
                                                                                                      if v.nil?
                                                                                                        ''
                                                                                                      else
                                                                                                        (v.empty? ? "" : v)
                                                                                                      end
                                                                                                    }
          map 'city', 'contact.mailing_address.address.location_city_name'
          map 'county', 'contact.mailing_address.address.location_county_name'
          # map 'county_fips', 'contact.mailing_address.address.location_county_code'
          map 'state', 'contact.mailing_address.address.location_state_us_postal_service_code'
          map 'zip', 'contact.mailing_address.address.location_postal_code'
          add_key 'contact.telephone_number'
          map 'kind', 'category_code', memoize: true, visible: true, function: lambda { |v|
            v.capitalize
          }
          add_key 'is_primary_indicator', value: lambda { |v|
            kind = v.resolve('category_code').item
            @contact_method == kind
          }
        end
      end
    end
  end
end