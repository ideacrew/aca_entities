# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class ErrorMessageDetail
              include HappyMapper
              register_namespace 'ext', 'http://ifsv.dsh.cms.gov/extension/1.0'

              tag 'ErrorMessageDetail'
              namespace 'ext'

              has_one :ResponseMetadata, ResponseMetadata
              element :XPathContent, String, tag: 'XPathContent', namespace: "ext"

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.ResponseMetadata = ResponseMetadata.domain_to_mapper(response.ResponseMetadata)
                mapper.XPathContent = response.XPathContent

                mapper
              end
            end
          end
        end
      end
    end
  end
end