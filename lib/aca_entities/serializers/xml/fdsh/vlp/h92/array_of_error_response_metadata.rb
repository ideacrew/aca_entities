# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an ArrayOfErrorResponseMetadata.
            class ArrayOfErrorResponseMetadata
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'ArrayOfErrorResponseMetadata'
              namespace 'vlp'

              has_many :ErrorResponseMetadata, ErrorResponseMetadata

              def self.domain_to_mapper(error_response_metadatas)
                mapper = self.new
                mapper.ErrorResponseMetadata = error_response_metadatas.collect do |error_response_metadata|
                  ErrorResponseMetadata.domain_to_mapper(error_response_metadata)
                end

                mapper
              end
            end
          end
        end
      end
    end
  end
end