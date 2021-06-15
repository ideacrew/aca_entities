# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class StatusValidDateRange
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'StatusValidDateRange'
            namespace 'hix-core'

            has_one :start_date, StartDate
            has_one :end_date, EndDate

            def self.domain_to_mapper(reference)
              mapper = self.new
              mapper.ref = "reference-id"
              mapper
            end
          end
        end
      end
    end
  end
end