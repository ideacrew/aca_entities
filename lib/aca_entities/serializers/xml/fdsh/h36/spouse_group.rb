# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an SpouseGroup.
          class SpouseGroup
            include HappyMapper

            tag 'SpouseGrp'

            has_one :Spouse, Spouse

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.Spouse = Spouse.domain_to_mapper(request.Spouse)

              mapper
            end
          end
        end
      end
    end
  end
end