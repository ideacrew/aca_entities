# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # Request.
            class ResponseMetadata
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'ResponseMetadata'
              namespace 'extn'

              attribute :ResponseCode, String, tag: 'ResponseCode', namespace: "extn"
              attribute :ResponseDescriptionText, String, tag: 'ResponseDescriptionText', namespace: "extn"
              attribute :TDSResponseDescriptionText, String, tag: 'TDSResponseDescriptionText', namespace: "extn"

              def self.domain_to_mapper(initial_request)
                mapper = self.new
                mapper.ResponseCode = initial_request.ResponseCode
                mapper.ResponseDescriptionText = initial_request.ResponseDescriptionText
                mapper.TDSResponseDescriptionText = initial_request.TDSResponseDescriptionText

                mapper
              end
            end
          end
        end
      end
    end
  end
end