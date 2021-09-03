# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class ResponseMetadata
              include HappyMapper
              register_namespace 'hcore', 'http://hix.cms.gov/0.1/hix-core'

              tag 'ResponseMetaData'
              namespace 'hcore'

              element :ResponseCode, String, tag: 'ResponseCode', namespace: "hcore"
              element :ResponseDescriptionText, String, tag: 'ResponseDescriptionText', namespace: "hcore"
              element :TDSResponseDescriptionText, String, tag: 'TDSResponseDescriptionText', namespace: "hcore"

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.ResponseCode = response.ResponseCode
                mapper.ResponseDescriptionText = response.ResponseDescriptionText
                mapper.TDSResponseDescriptionText = response.TDSResponseDescriptionText

                mapper
              end
            end
          end
        end
      end
    end
  end
end