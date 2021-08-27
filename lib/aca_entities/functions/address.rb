# frozen_string_literal: true

module AcaEntities
  module Functions
    # build person address
    class Address
      def call(value)
        # require 'pry';binding.pry

        # namespace 'mailingAddress' do
        #   rewrap 'family.family_members.person.addresses', type: :array do
        #     add_key 'kind', value: 'mailing'
        #     map 'streetName1', 'address_1'
        #     add_key 'address_2'
        #     add_key 'address_3'
        #     map 'cityName', 'city'
        #     map 'countyName', 'county'
        #     map 'countyFipsCode', 'county_code'
        #     map 'stateCode', 'state'
        #     map 'zipCode', 'zip'
        #     map 'countryCode', 'country_name'
        #   end
        # end

        # namespace 'homeAddress' do
        #   rewrap 'family.family_members.person.addresses', type: :array do
        #     add_key 'kind', value: 'home'
        #     map 'streetName1', 'address_1'
        #     add_key 'address_2'
        #     add_key 'address_3'
        #     map 'cityName', 'city'
        #     map 'countyName', 'county'
        #     map 'countyFipsCode', 'county_code'
        #     map 'stateCode', 'state'
        #     map 'zipCode', 'zip'
        #     map 'countryCode', 'country_name'
        #   end
        # end

        # if value.resolve('family.family_members.is_primary_applicant').item == value.find(Regexp.new("attestations.members")).map(&:item).last
        #   [{ address: value.resolve('family.family_members.person.email.address').item, kind: 'home' }]
        # end
      end
    end
  end
end