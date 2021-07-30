# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # xml mapping Atp::InsuranceApplicantEsiPlannedCoverageDateRange
          class InsuranceApplicantEsiPlannedCoverageDateRange
            include HappyMapper

            tag 'InsuranceApplicantESIPlannedCoverageDateRange'
            namespace 'hix-ee'

            has_one :end_date, EndDate
            has_one :start_date, StartDate

            def self.domain_to_mapper(date_range)
              mapper = self.new
              mapper.end_date = date_range.end_date
              mapper.start_date = date_range.start_date
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