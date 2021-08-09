# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # response.
            class SSAIncarcerationInformation
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'SSAIncarcerationInformation'
              namespace 'extn'

              element :PrisonerIdentification, String, tag: 'PrisonerIdentification', namespace: "extn"
              element :PrisonerConfinementDate, String, tag: 'PrisonerConfinementDate', namespace: "extn"
              element :ReportingPersonText, String, tag: 'ReportingPersonText', namespace: "extn"
              has_one :SupervisionFacility, SupervisionFacility
              element :InmateStatusIndicator, Boolean, tag: 'InmateStatusIndicator', namespace: "extn"

              def self.domain_to_mapper(initial_request)
                mapper = self.new

                mapper.PrisonerIdentification = initial_request.PrisonerIdentification
                mapper.PrisonerConfinementDate = initial_request.PrisonerConfinementDate
                mapper.ReportingPersonText = initial_request.ReportingPersonText
                mapper.SupervisionFacility = SupervisionFacility.domain_to_mapper(initial_request.SupervisionFacility)
                mapper.InmateStatusIndicator = initial_request.InmateStatusIndicator

                mapper
              end
            end
          end
        end
      end
    end
  end
end