# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck

          # Happymapper implementation for the root object of an response.
          class NonEsiMecResponse
            include HappyMapper
            register_namespace 'gov', 'http://gov.hhs.cms.hix.dsh.ee.nonesi_mec.ext'

            tag 'NonESIMECResponse'
            namespace 'gov'

            element :response_code, String, tag: 'ResponseCode', namespace: "gov"
            element :response_description, String, tag: 'ResponseDescription', namespace: "gov"
            has_one :non_esi_mec_individual_response, NonEsiMecIndividualResponse

            def to_hash
              {
                response_code: response_code,
                response_description: response_description,
                non_esi_mec_individual_response: non_esi_mec_individual_response.to_hash
              }
            end
          end
        end
      end
    end
  end
end
