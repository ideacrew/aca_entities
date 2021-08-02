# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # Request.
          class Request
            include HappyMapper
            register_namespace 'exch', 'http://ridp.dsh.cms.gov/exchange/1.0'

            tag 'Request'
            namespace 'exch'

            has_one :PrimaryRequest, PrimaryRequest
            has_one :SecondaryRequest, SecondaryRequest

            def self.domain_to_mapper(request, type)
              mapper = self.new
              mapper.PrimaryRequest = PrimaryRequest.domain_to_mapper(request) if type == 'primary_request'
              mapper.SecondaryRequest = SecondaryRequest.domain_to_mapper(request) if type == 'secondary_request'
              mapper
            end
          end
        end
      end
    end
  end
end

