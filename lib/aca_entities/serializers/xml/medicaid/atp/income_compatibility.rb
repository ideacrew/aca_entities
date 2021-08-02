# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for an assessment of income reasonable compatibility
          class IncomeCompatibility
            include HappyMapper

            tag 'IncomeCompatibility'
            namespace 'hix-ee'

            has_one :verification_indicator, Boolean, tag: "IncomeCompatibilityVerificationIndicator"
            has_one :inconsistency_reason_text, String, tag: "IncomeCompatibilityInconsistencyReasonText"
            has_one :compatibility_determination, IncomeCompatibilityDetermination
            has_one :verification_method, String, tag: "IncomeCompatibilityVerificationMethod"

            def self.domain_to_mapper(income_compatibility)
              mapper = self.new
              mapper.verification_indicator = income_compatibility.verification_indicator
              mapper.inconsistency_reason_text = income_compatibility.inconsistency_reason_text
              mapper.compatibility_determination = IncomeCompatibilityDetermination.domain_to_mapper(income_compatibility.compatibility_determination)
              mapper.verification_method = income_compatibility.verification_method
              mapper
            end

            def to_hash
              {
                verification_indicator: verification_indicator&.to_hash,
                inconsistency_reason_text: inconsistency_reason_text&.to_hash,
                compatibility_determination: compatibility_determination&.to_hash,
                verification_method: verification_method&.to_hash
              }
            end
          end
        end
      end
    end
  end
end