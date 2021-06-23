# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          class InsuranceApplicantEsiPlannedCoverageDateRange
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'InsuranceApplicantESIPlannedCoverageDateRange'
            namespace 'hix-ee'

            has_one :end_date, EndDate
            has_one :start_date, StartDate

            def self.domain_to_mapper(date_range)
              mapper = self.new
              mapper
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