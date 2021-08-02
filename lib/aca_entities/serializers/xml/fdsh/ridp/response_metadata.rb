# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # ResponseMetadata.
          class ResponseMetadata
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'ResponseMetadata'
            namespace 'hix-core'

            element :ResponseCode, String, tag: "ResponseCode"
            element :ResponseDescriptionText, String, tag: "ResponseDescriptionText"
            element :TDSResponseDescriptionText, String, tag: "TDSResponseDescriptionText"

            def self.domain_to_mapper(response_metadata)
              mapper = self.new
              mapper.ResponseCode = response_metadata.ResponseCode
              mapper.ResponseDescriptionText = response_metadata.ResponseDescriptionText
              mapper.TDSResponseDescriptionText = response_metadata.TDSResponseDescriptionText
              mapper
            end
          end
        end
      end
    end
  end
end