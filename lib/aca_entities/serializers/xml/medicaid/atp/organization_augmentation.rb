# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type that supplements an nc:Organization with health insurance specific information.
          class OrganizationAugmentation
            include HappyMapper

            tag 'OrganizationAugmentation'
            namespace 'hix-core'

            has_one :tin_identification, TinIdentification

            def self.domain_to_mapper(augementation)
              mapper = self.new
              mapper.tin_identification = TinIdentification.domain_to_mapper(augementation.tin_identification)
              mapper
            end

            def to_hash
              {
                tin_identification: tin_identification
              }
            end
          end
        end
      end
    end
  end
end