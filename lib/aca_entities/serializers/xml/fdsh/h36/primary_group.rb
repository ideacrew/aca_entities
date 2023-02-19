# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an PrimaryGroup.
          class PrimaryGroup
            include HappyMapper

            tag 'PrimaryGrp'

            has_one :Primary, Primary

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.Primary = Primary.domain_to_mapper(request.Primary)

              mapper
            end
          end
        end
      end
    end
  end
end