# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Ifsv
            # Happymapper implementation for the root object of an Response.
            class IfsvResponseCodeDetail
              include HappyMapper
              register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

              tag 'IFSVResponseCodeDetail'
              namespace 'irs'

              element :ResponseCd, String, tag: 'ResponseCd', namespace: 'irs'
              element :ResponseCodeDescription, String, tag: 'ResponseCodeDescription', namespace: 'irs'

              def self.domain_to_mapper(response_code)
                mapper = self.new
                mapper.ResponseCd = response_code.ResponseCd
                mapper.ResponseCodeDescription = response_code.ResponseCodeDescription

                mapper
              end
            end
          end
        end
      end
    end
  end
end
