# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class ReferralActivityStatus
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'ReferralActivityStatus'
            namespace 'hix-ee'

            element :status_code, String, tag: 'ReferralActivityStatusCode'
            element :overall_verification_status_code, String, tag: 'ReferralActivityOverallVerificationStatusCode'
            has_one :valid_date_range, StatusValidDateRange

            def self.domain_to_mapper(reference)
              mapper = self.new
              mapper.ref = "reference-id"
              mapper
            end
          end
        end
      end
    end
  end
end