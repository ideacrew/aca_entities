# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # ResponseMetadata.
            class ResponseMetadata
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'ResponseMetadata'
              namespace 'vlp'

              element :ResponseCode, String, tag: "ResponseCode"
              element :ResponseDescriptionText, String, tag: "ResponseDescriptionText"
              element :TDSResponseDescriptionText, String, tag: "TDSResponseDescriptionText"

              def self.domain_to_mapper(response_metadata)
                mapper = self.new
                mapper.ResponseCode = response_metadata.ResponseCode
                mapper.ResponseDescriptionText = response_metadata.response_description_text
                mapper.TDSResponseDescriptionText = response_metadata.TDSResponseDescriptionText
                mapper
              end
            end
          end
        end
      end
    end
  end
end