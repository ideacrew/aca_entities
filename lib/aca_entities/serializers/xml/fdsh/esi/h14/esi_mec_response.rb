# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an response.
            class EsiMecResponse
              include HappyMapper
              register_namespace 'exch', 'http://vesim.dsh.cms.gov/exchange/1.0'
              register_namespace 'ext', 'http://vesim.dsh.cms.gov/extension/1.0'

              tag 'ESIMECResponse'
              namespace 'exch'

              has_one :ApplicantResponseSet, ApplicantResponseSet
              has_one :ResponseMetadata, ResponseMetadata, tag: 'ext'

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.ApplicantResponseSet = response.ApplicantResponseSet
                mapper.ResponseMetadata = response.ResponseMetadata if response.ResponseMetadata

                mapper
              end
            end
          end
        end
      end
    end
  end
end
