# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an InsuranceApplicantResponse.
            class InsuranceApplicantResponse
              include HappyMapper
              register_namespace 'ext', 'http://vesim.dsh.cms.gov/extension/1.0'
              register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

              tag 'InsuranceApplicantResponse'
              namespace 'ext'

              has_one :InsuranceApplicantRequestedCoverage, InsuranceApplicantRequestedCoverage
              element :InsuranceApplicantEligibleEmployerSponsoredInsuranceIndicator, Boolean,
                      tag: 'InsuranceApplicantEligibleEmployerSponsoredInsuranceIndicator', namespace: 'hix-ee'
              element :InsuranceApplicantInsuredIndicator, Boolean, tag: 'InsuranceApplicantInsuredIndicator', namespace: 'hix-ee'

              def self.domain_to_mapper(applicant_response)
                mapper = self.new
                mapper.InsuranceApplicantRequestedCoverage =
                  InsuranceApplicantRequestedCoverage.domain_to_mapper(applicant_response.InsuranceApplicantRequestedCoverage)

                mapper.InsuranceApplicantEligibleEmployerSponsoredInsuranceIndicator =
                  applicant_response.InsuranceApplicantEligibleEmployerSponsoredInsuranceIndicator

                mapper.InsuranceApplicantInsuredIndicator = applicant_response.InsuranceApplicantInsuredIndicator

                mapper
              end
            end
          end
        end
      end
    end
  end
end
