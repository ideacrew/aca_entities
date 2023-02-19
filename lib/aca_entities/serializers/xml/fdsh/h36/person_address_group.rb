# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an PersonAddressGroup.
          class PersonAddressGroup
            include HappyMapper

            tag 'PersonAddressGrp'

            has_one :UsAddressGroup, UsAddressGroup

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.UsAddressGroup = UsAddressGroup.domain_to_mapper(request.UsAddressGroup)

              mapper
            end
          end
        end
      end
    end
  end
end