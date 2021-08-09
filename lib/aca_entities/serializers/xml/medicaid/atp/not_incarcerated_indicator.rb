# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class NotIncarceratedIndicator
            include HappyMapper

            tag 'SSFAttestationNotIncarceratedIndicator'
            namespace 'hix-ee'

            attribute :metadata, String, namespace: "niem-s"
            content :value, Boolean

            def self.domain_to_mapper(incarceration_indicator)
              mapper = self.new
              mapper.metadata = incarceration_indicator.metadata
              mapper.value = incarceration_indicator.value
              mapper
            end

            def to_hash
              {
                value: value,
                metadata: metadata
              }
            end
          end
        end
      end
    end
  end
end