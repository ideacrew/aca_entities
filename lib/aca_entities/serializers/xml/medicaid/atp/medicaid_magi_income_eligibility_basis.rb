# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A basis for Medicaid MAGI (Modified Adjusted Gross Income) eligibility based on income rules.
          class MedicaidMagiIncomeEligibilityBasis
            include HappyMapper

            tag 'MedicaidMAGIIncomeEligibilityBasis'
            namespace 'hix-ee'

            element :status_indicator, Boolean, tag: 'StatusIndicator', namespace: "hix-core"
            element :eligibility_basis_status_code, Boolean, tag: 'EligibilityBasisStatusCode', namespace: "hix-ee"
            element :ineligibility_reason_text, String, tag: 'EligibilityBasisIneligibilityReasonText', namespace: "hix-ee"
            has_one :eligibility_basis_determination, EligibilityBasisDetermination
            element :state_threshold_fpl_percent, String, tag: 'IncomeEligibilityBasisStateThresholdFPLPercent', namespace: "hix-ee"
            has_one :income_compatibility, IncomeCompatibility

            def self.domain_to_mapper(ieb)
              mapper = self.new
              mapper.status_indicator = ieb.status_indicator
              mapper.eligibility_basis_status_code = ieb.eligibility_basis_status_code
              mapper.ineligibility_reason_text = ieb.ineligibility_reason_text
              mapper.eligibility_basis_determination = EligibilityBasisDetermination.domain_to_mapper(ieb.eligibility_basis_determination)
              mapper.state_threshold_fpl_percent = ieb.state_threshold_fpl_percent
              mapper.income_compatibility = IncomeCompatibility.domain_to_mapper(ieb.income_compatibility)
              mapper
            end

            def to_hash
              {
                status_indicator: status_indicator,
                eligibility_basis_status_code: eligibility_basis_status_code,
                ineligibility_reason_text: ineligibility_reason_text,
                eligibility_basis_determination: eligibility_basis_determination
              }
            end
          end
        end
      end
    end
  end
end