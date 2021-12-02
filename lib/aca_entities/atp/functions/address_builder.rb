# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions
      # build application and applicants
      class AddressBuilder
        def call(cache, m_identifier = nil)
          @memoized_data = cache
          member_id = m_identifier || '*'
          contacts_information = @memoized_data.find(Regexp.new("record.people.#{member_id}.augementation")).map(&:item).last[:contacts]

          contacts_information.each_with_object([]) do |contact_info, collector|
            next if contact_info[:category_code].downcase == 'residency'
            address = contact_info.dig(:contact, :mailing_address, :address)

            collector << address_hash(address, contact_info) if address
          end
        end

        private

        def address_hash(address, contact_info)
          zip = address[:location_postal_code]
          zip.insert(5, '-') if zip.length == 9 # 9-digit zip code must include '-'
          {
            kind: contact_info[:category_code].downcase,
            address_1: address[:location_street][:street_full_text],
            address_2: address[:address_secondary_unit_text],
            address_3: nil,
            city: address[:location_city_name],
            county: address[:location_county_name]&.capitalize,
            county_code: address[:location_county_code],
            state: address[:location_state_us_postal_service_code],
            zip: zip,
            country_name: nil
          }
        end
      end
    end
  end
end
