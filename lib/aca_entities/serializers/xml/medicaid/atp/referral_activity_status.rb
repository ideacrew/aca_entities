# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class ReferralActivityStatus
            include HappyMapper

            tag 'ReferralActivityStatus'
            namespace 'hix-ee'

            element :status_code, String, tag: 'ReferralActivityStatusCode'
            element :overall_verification_status_code, String, tag: 'ReferralActivityOverallVerificationStatusCode'
            has_one :valid_date_range, StatusValidDateRange

            def self.domain_to_mapper(ras)
              mapper = self.new
              mapper.status_code = ras.status_code
              mapper.overall_verification_status_code = ras.overall_verification_status_code
              # mapper.valid_date_range = StatusValidDateRange.domain_to_mapper(ras.valid_date_range)
              mapper
            end

            def to_hash
              {
                status_code: status_code,
                overall_verification_status_code: overall_verification_status_code,
                valid_date_range: valid_date_range&.to_hash
              }
            end
          end
        end
      end
    end
  end
end