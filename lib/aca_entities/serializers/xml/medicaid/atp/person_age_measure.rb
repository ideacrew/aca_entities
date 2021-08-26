# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions. A measurement of the age of a person.
          class PersonAgeMeasure
            include HappyMapper

            tag 'PersonAgeMeasure'
            namespace 'nc'

            element :measure_point_value, Integer, tag: "MeasurePointValue", namespace: "nc"

            def self.domain_to_mapper(age)
              mapper = self.new
              mapper.measure_point_value = age.measure_point_value if age.respond_to?(:measure_point_value)
              mapper
            end

            def to_hash
              {
                measure_point_value: measure_point_value
              }
            end
          end
        end
      end
    end
  end
end