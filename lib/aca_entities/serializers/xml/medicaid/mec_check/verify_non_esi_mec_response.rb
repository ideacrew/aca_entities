# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck
          # Happymapper implementation for the root object of an response.
          class VerifyNonEsiMecResponse
            include HappyMapper
            register_namespace 'gov', 'http://gov.hhs.cms.hix.dsh.ee.nonesi_mec.ext'

            tag 'VerifyNonESIMECResponse'
            namespace 'gov'

            has_one :non_esi_mec_response, NonEsiMecResponse

            def self.domain_to_mapper(response)
              mapper = self.new
              mapper.non_esi_mec_response = NonEsiMecResponse.domain_to_mapper(response.non_esi_mec_response)

              mapper
            end

            def to_hash
              {
                non_esi_mec_response: non_esi_mec_response.to_hash
              }
            end
          end
        end
      end
    end
  end
end
