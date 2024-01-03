# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module Rx142
            module CloseCase
              # Happymapper implementation for the root object of an ErrorResponseMetadata.
              class ErrorResponseMetadata
                include HappyMapper
                register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

                tag 'ErrorResponseMetadata'
                namespace 'hix-core'

                element :ErrorResponseCode, String, tag: "ErrorResponseCode"
                element :ErrorResponseDescriptionText, String, tag: "ErrorResponseDescriptionText"
                element :ErrorTDSResponseDescriptionText, String, tag: "ErrorTDSResponseDescriptionText"

                def self.domain_to_mapper(response_metadata)
                  mapper = self.new
                  mapper.ErrorResponseCode = response_metadata.ErrorResponseCode
                  mapper.ErrorResponseDescriptionText = response_metadata.ErrorResponseDescriptionText
                  mapper.ErrorTDSResponseDescriptionText = response_metadata.ErrorTDSResponseDescriptionText

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