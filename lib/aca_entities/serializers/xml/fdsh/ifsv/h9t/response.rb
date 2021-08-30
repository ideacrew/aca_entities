# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class Response
              include HappyMapper
              register_namespace 'exch', 'http://ifsv.dsh.cms.gov/exchange/1.0'
              register_namespace 'hcore', 'http://hix.cms.gov/0.1/hix-core'

              tag 'IFSVResponse'
              namespace 'exch'

              has_one :IRSResponse, IRSResponse
              has_one :ErrorMessage, ErrorMessage

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.IRSResponse = IRSResponse.domain_to_mapper(response.IRSResponse)
                mapper.ErrorMessage = ErrorMessage.domain_to_mapper(response.ErrorMessage)
                mapper
              end
            end
          end
        end
      end
    end
  end
end