# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module Rx1424
            # Happymapper implementation for the root object of an
            # ResponseMetadata.
            class ResponseMetadata
              include HappyMapper
              register_namespace 'vlpcc', 'http://vclpcc.ee.sim.dsh.cms.hhs.gov'

              tag 'ResponseMetadata'
              namespace 'vlpcc'

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
end