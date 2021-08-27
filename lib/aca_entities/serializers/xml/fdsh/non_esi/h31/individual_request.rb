# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the root object of an Request.
            class IndividualRequest
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'
              register_namespace 'ns1', 'http://niem.gov/niem/niem-core/2.0'

              tag 'IndividualRequest'
              namespace 'vnem'

              has_one :Applicant, Applicant
              element :LocationStateUSPostalServiceCode, String, tag: 'LocationStateUSPostalServiceCode', namespace: 'ns1'
              has_one :InsurancePolicy, InsurancePolicy
              element :Organization, Organization

              def self.domain_to_mapper(individual_request)
                mapper = self.new
                mapper.Applicant = Applicant.domain_to_mapper(individual_request.Applicant)
                mapper.LocationStateUSPostalServiceCode = individual_request.LocationStateUSPostalServiceCode
                mapper.InsurancePolicy = InsurancePolicy.domain_to_mapper(individual_request.InsurancePolicy)
                mapper.Organization = Organization.domain_to_mapper(individual_request.Organization) if individual_request.Organization

                mapper
              end
            end
          end
        end
      end
    end
  end
end
