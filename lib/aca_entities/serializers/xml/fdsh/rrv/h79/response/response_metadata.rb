# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module H79
            module Response
              # Happymapper implementation for the root object of an ResponseMetadata.
              class ResponseMetadata
                include HappyMapper
                register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

                tag 'ResponseMetadata'
                namespace 'hix-core'

                element :ResponseDescriptionText, String, tag: 'ResponseDescriptionText', namespace: "hix-core"
                element :ResponseCode, String, tag: 'ResponseCode', namespace: "hix-core"
                element :TDSResponseDescriptionText, String, tag: 'TDSResponseDescriptionText', namespace: "hix-core"

                def self.domain_to_mapper(initial_request)
                  mapper = self.new
                  mapper.ResponseDescriptionText = initial_request.ResponseDescriptionText
                  mapper.ResponseCode = initial_request.ResponseCode
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
end