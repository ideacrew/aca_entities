# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Mapping xml's EligibilityDateRange
          class EligibilityDateRange
            include HappyMapper

            tag 'EligibilityDateRange'
            namespace 'hix-ee'

            has_one :end_date, EndDate
            has_one :start_date, StartDate

            def self.domain_to_mapper(_date_range)
              self.new
            end

            def to_hash
              {
                end_date: end_date&.to_hash,
                start_date: start_date&.to_hash
              }
            end
          end
        end
      end
    end
  end
end