# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # response.
            class SupervisionFacility
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'SupervisionFacility'
              namespace 'extn'

              attribute :FacilityName, String, tag: 'FacilityName', namespace: "extn"
              has_one :FacilityLocation, FacilityLocation
              has_one :FacilityContactInformation, FacilityContactInformation
              attribute :FacilityCategoryCode, String, tag: 'FacilityCategoryCode', namespace: "extn"

              def self.domain_to_mapper(initial_response)
                mapper = self.new

                mapper.FacilityName = initial_response.FacilityName
                mapper.FacilityLocation = FacilityLocation.domain_to_mapper(initial_response.FacilityLocation)
                mapper.FacilityContactInformation = FacilityContactInformation.domain_to_mapper(initial_response.FacilityContactInformation)
                mapper.FacilityCategoryCode = initial_response.FacilityCategoryCode

                mapper
              end
            end
          end
        end
      end
    end
  end
end