# frozen_string_literal: true

module AcaEntities
  module Ffe
    module Transformers
      module Cv
        # build person address
        class Address < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'kind', 'kind'
          map 'streetName1', 'address_1'
          add_key 'address_2'
          add_key 'address_3'
          map 'cityName', 'city'
          map 'countyName', 'county'
          map 'countyFipsCode', 'county_code'
          map 'stateCode', 'state'
          map 'zipCode', 'zip'
          map 'countryCode', 'country_name'

        end
      end
    end
  end
end