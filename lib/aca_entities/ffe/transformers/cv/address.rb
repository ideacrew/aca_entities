# frozen_string_literal: true

module AcaEntities
  module Ffe
    module Transformers
      module Cv
        # Transform person address
        class Address < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'kind', 'kind'
          map 'streetName1', 'streetName1', memoize: true, visible: false
          add_key 'address_1', function: lambda { |v|
                                           return "no address" if v.nil? || v.resolve('streetName1').item.nil?
                                           v.resolve('streetName1').item
                                         }
          map 'streetName2', 'address_2'
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