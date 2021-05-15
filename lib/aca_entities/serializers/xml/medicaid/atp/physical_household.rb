# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          class PhysicalHousehold
            include HappyMapper
            register_namespace 'ext', 'http://at.dsh.cms.gov/extension/1.0'

            tag 'PhysicalHousehold'
            namespace 'ext'

            def self.domain_to_mapper(date_time)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end