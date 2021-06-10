# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ridp
          # Happymapper implementation for the root object of an
          # SecondaryResponse.
          class SecondaryResponse
            include HappyMapper
            register_namespace 'ex', 'http://ridp.dsh.cms.gov/exchange/1.0'
            register_namespace 'ext', 'http://ridp.dsh.cms.gov/extension/1.0'

            has_one :response_metadata, ResponseMetadata, namespace: 'hix-core:ResponseMetadata'
            has_one :verification_response, VerificationResponse, namespace: 'VerificationResponse'

            def self.domain_to_mapper(secondary_response)
              mapper = self.new
              mapper.response_metadata = ResponseMetadata.domain_to_mapper(secondary_response.response_metadata)
              mapper.verification_response = VerificationResponse.domain_to_mapper(secondary_response.verification_response)
              mapper
            end
          end
        end
      end
    end
  end
end