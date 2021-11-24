# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An insurance policy associated with an applicant that is not an employer sponsored insurance (ESI) arrangement.
          class InsuranceApplicantNonEsiPolicy
            include HappyMapper

            tag 'InsuranceApplicantNonESIPolicy'
            namespace 'hix-ee'

            # A person who has health insurance coverage.
            # (An insurance member is called a beneficiary when Centers for Medicare &amp; Medicaid Services provides the coverage).
            element :member, InsuranceMember

            # An identification of the policy.
            element :policy_id, InsurancePolicyIdentification

            # A periodic payment made on an insurance policy.
            element :premium, InsurancePremium

            # A source that offers insurance policies.
            element :source_code, String, tag: 'InsurancePolicySourceCode'

            # A date range for which a policy is actually effective
            # (i.e., taking into consideration when the policy actually took effect, was cancelled, etc.).
            element :applied_effective_date_range, InsurancePolicyAppliedEffectiveDateRange

            def self.domain_to_mapper(nep)
              mapper = self.new
              mapper.member = InsuranceMember.domain_to_mapper(nep.member) if nep.member
              mapper.policy_id = InsurancePolicyIdentification.domain_to_mapper(nep.policy_id) if nep.policy_id
              mapper.premium = InsurancePremium.domain_to_mapper(nep.premium) if nep.premium
              mapper.source_code = nep.source_code
              if nep.applied_effective_date_range
                mapper.applied_effective_date_range = InsurancePolicyAppliedEffectiveDateRange.domain_to_mapper(nep.applied_effective_date_range)
              end
              mapper
            end

            def to_hash
              {
                member: member&.to_h,
                policy_id: policy_id&.to_h,
                premium: premium&.to_h,
                source_code: source_code,
                applied_effective_date_range: applied_effective_date_range&.to_h
              }
            end
          end
        end
      end
    end
  end
end