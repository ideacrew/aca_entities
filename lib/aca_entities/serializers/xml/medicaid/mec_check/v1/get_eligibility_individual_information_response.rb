# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck
          # Happymapper implementation for the root object of a non-ESI MEC response.
          class GetEligibilityIndividualInformationResponse
            include HappyMapper
            tag 'GetEligibilityResponse'

            element :eligibility_flag, String, tag: "EligibilityFlag"
            element :resp_code, String, tag: "RespCode"

            def to_hash
              { eligibility_flag: eligibility_flag, resp_code: resp_code }
            end
          end
        end
      end
    end
  end
end
