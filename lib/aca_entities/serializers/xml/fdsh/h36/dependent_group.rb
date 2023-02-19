# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an DependentGroup.
          class DependentGroup
            include HappyMapper

            tag 'DependentGrp'

            has_one :DependentPerson, DependentPerson

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.DependentPerson = DependentPerson.domain_to_mapper(request.DependentPerson)

              mapper
            end
          end
        end
      end
    end
  end
end
