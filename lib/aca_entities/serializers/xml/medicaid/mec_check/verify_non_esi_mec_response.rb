# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck
          # Happymapper implementation for the root object of a non-ESI MEC response.
          class VerifyNonEsiMecResponse
            include HappyMapper
            register_namespace 'gov', 'http://gov.hhs.cms.hix.dsh.ee.nonesi_mec.ext'

            tag 'VerifyNonESIMECResponse'
            namespace 'gov'

            has_one :non_esi_mec_response, NonEsiMecResponse

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
