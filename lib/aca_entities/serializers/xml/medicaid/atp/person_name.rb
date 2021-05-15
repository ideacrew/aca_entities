# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          class PersonName
            include HappyMapper
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'PersonName'
            namespace 'nc'

            def self.domain_to_mapper(person)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end