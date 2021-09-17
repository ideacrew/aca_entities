# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck
          # Happymapper implementation for the root object of a VerifyNonESIMECRequest.
          class VerifyNonEsiMecRequest
            include HappyMapper
            register_namespace 'gov', 'http://gov.hhs.cms.hix.dsh.ee.nonesi_mec.ext'

            tag 'VerifyNonESIMECRequest'
            namespace 'gov'

            # A entity that starts the referral process.
            has_one :non_esi_mec_request, NonEsiMecRequest

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.non_esi_mec_request = NonEsiMecRequest.domain_to_mapper(request.non_esi_mec_request)
              mapper
            end

            def to_hash()
              {
                non_esi_mec_request: non_esi_mec_request.to_hash,
              }
            end
          end
        end
      end
    end
  end
end