# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # response.
            class FacilityContactInformation
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'FacilityContactInformation'
              namespace 'extn'

              element :PersonFullName, String, tag: 'PersonFullName', namespace: "extn"
              element :ContactTelephoneNumber, String, tag: 'ContactTelephoneNumber', namespace: "extn"
              element :ContactFaxNumber, String, tag: 'ContactFaxNumber', namespace: "extn"

              def self.domain_to_mapper(initial_response)
                mapper = self.new

                mapper.PersonFullName = initial_response.PersonFullName
                mapper.ContactTelephoneNumber = initial_response.ContactTelephoneNumber
                mapper.ContactFaxNumber = initial_response.ContactFaxNumber

                mapper
              end
            end
          end
        end
      end
    end
  end
end