# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the root object of an
            # Request.
            class ResponseMetadata
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'

              tag 'ResponseMetadata'
              namespace 'vnem'

              element :ResponseCode, String, tag: 'ResponseCode', namespace: "vnem"
              element :ResponseDescriptionText, String, tag: 'ResponseDescriptionText', namespace: "vnem"
              element :TDSResponseDescriptionText, String, tag: 'TDSResponseDescriptionText', namespace: "vnem"

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