# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A basis for Children's Health Insurance Program (CHIP) eligibility based on incarceration rules.
          class ChipIncarcerationEligibilityBasis
            include HappyMapper

            tag 'CHIPIncarcerationEligibilityBasis'
            namespace 'hix-ee'

            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "hix-core"
            element :status_valid_date_range, StatusValidDateRange, tag: 'StatusValidDateRange', namespace: "hix-core"
            element :status_code, String, tag: 'EligibilityBasisStatusCode', namespace: "hix-ee"
            element :ineligibility_reason_text, String, tag: 'EligibilityBasisIneligibilityReasonText', namespace: "hix-ee"
            element :inconsistency_reason_text, String, tag: 'EligibilityBasisInconsistencyReasonText', namespace: "hix-ee"
            element :pending_reason_text, String, tag: 'EligibilityBasisPendingReasonText', namespace: "hix-ee"
            element :determination, EligibilityBasisDetermination, tag: 'EligibilityBasisDetermination', namespace: "hix-ee"

            def self.domain_to_mapper(eligibility_basis)
              mapper = self.new
              mapper.status_indicator = eligibility_basis.status_indicator
              mapper.status_valid_date_range = StastusValidDateRange.domain_to_mapper(eligibility_basis.status_valid_date_range)
              mapper.status_code = eligibility_basis.status_code
              mapper.ineligibility_reason_text = eligibility_basis.ineligibility_reason_text
              mapper.inconsistency_reason_text = eligibility_basis.inconsistency_reason_text
              mapper.pending_reason_text = eligibility_basis.pending_reason_text
              mapper.determination = EligibilityBasisDetermination.domain_to_mapper(eligibility_basis.determination)
              mapper
            end

            def to_hash
              {
                status_indicator: status_indicator,
                status_valid_date_range: status_valid_date_range,
                status_code: status_code,
                ineligibility_reason_text: ineligibility_reason_text,
                inconsistency_reason_text: inconsistency_reason_text,
                pending_reason_text: pending_reason_text,
                determination: determination
              }
            end
          end
        end
      end
    end
  end
end