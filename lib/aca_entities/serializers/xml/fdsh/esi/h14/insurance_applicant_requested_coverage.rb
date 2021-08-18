# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an Request.
            class InsuranceApplicantRequestedCoverage
              include HappyMapper
              register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

              tag 'InsuranceApplicantRequestedCoverage'
              namespace 'hix-ee'

              has_one :StartDate, StartDate
              has_one :EndDate, EndDate

              def self.domain_to_mapper(coverage)
                mapper = self.new
                mapper.StartDate = StartDate.domain_to_mapper(coverage.StartDate)
                mapper.EndDate = EndDate.domain_to_mapper(coverage.EndDate)

                mapper
              end
            end
          end
        end
      end
    end
  end
end
