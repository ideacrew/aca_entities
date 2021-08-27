# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an Request.
            class InsuranceApplicantRequest
              include HappyMapper
              register_namespace 'ext', 'http://vesim.dsh.cms.gov/extension/1.0'

              tag 'InsuranceApplicantRequest'
              namespace 'ext'

              has_one :InsuranceApplicantRequestedCoverage, InsuranceApplicantRequestedCoverage

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.InsuranceApplicantRequestedCoverage =
                  InsuranceApplicantRequestedCoverage.domain_to_mapper(request.InsuranceApplicantRequestedCoverage)

                mapper
              end
            end
          end
        end
      end
    end
  end
end
