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

            tag 'hix-core:ResponseMetadata'
            namespace 'hix-core'

            element :response_code, String, tag: "ResponseCode", namespace: 'hix-core'
            element :response_description_text, String, tag: "ResponseDescriptionText", namespace: 'hix-core'
            element :tds_response_description_text, String, tag: "TDSResponseDescriptionText", namespace: 'hix-core'

            def self.domain_to_mapper(initial_response)
              mapper = self.new
              mapper.version = "1.0"
              mapper.response_code = initial_response.response_code
              mapper.response_description_text = initial_response.response_description_text
              mapper.tds_response_description_text = initial_response.response_description_text
              mapper
            end
          end
        end
      end
    end
  end
end