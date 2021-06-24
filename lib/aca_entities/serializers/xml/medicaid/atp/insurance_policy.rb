# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for an agreement by an issuer to provide coverage under an insurance plan to a set of members who subscribe as a unit.
          class InsurancePolicy
            include HappyMapper

            tag 'InsurancePolicy'
            namespace 'hix-ee'

            # A person who has health insurance coverage.
            # (An insurance member is called a beneficiary when Centers for Medicare &amp; Medicaid Services provides the coverage).
            element :member, String, tag: 'InsuranceMember'

            # An identification of the policy.
            element :policy_id, String, tag: 'InsurancePolicyIdentification'

            # A periodic payment made on an insurance policy.
            element :premium, String, tag: 'InsurancePremium'

            # A source that offers insurance policies.
            element :source_code, String, tag: 'InsurancePolicySourceCode'

            # A date range for which a policy is actually effective
            # (i.e., taking into consideration when the policy actually took effect, was cancelled, etc.).
            element :applied_effective_date_range, String, tag: 'InsurancePolicyAppliedEffectiveDateRange'

            def self.domain_to_mapper(_insurance_policy)
              self.new
            end

            def to_hash
              {
                member: member,
                policy_id: policy_id,
                premium: premium,
                source_code: source_code,
                applied_effective_date_range: applied_effective_date_range
              }
            end
          end
        end
      end
    end
  end
end