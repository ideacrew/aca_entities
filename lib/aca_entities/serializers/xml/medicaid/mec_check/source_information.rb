# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck
          # Happymapper implementation for the root object of an Individual response.
          class SourceInformation
            include HappyMapper
            register_namespace 'gov', 'http://gov.hhs.cms.hix.dsh.ee.nonesi_mec.ext'

            tag 'SourceInformation'
            namespace 'gov'

            has_one :mec_verification_code, String, tag: 'MECVerificationCode', namespace: 'gov'

            def self.domain_to_mapper(response)
              mapper = self.new
              mapper.mec_verification_code = response.mec_verification_code

              mapper
            end

            def to_hash
              {
                mec_verification_code: mec_verification_code
              }
            end
          end
        end
      end
    end
  end
end
