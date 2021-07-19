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

            element :member, String, tag: 'InsuranceMember'

            element :applied_effective_date_range, String, tag: 'InsurancePolicyAppliedEffectiveDateRange'

            has_one :identification, InsurancePolicyIdentification

            # A source that offers insurance policies
            element :source_code, String, tag: 'InsurancePolicySourceCode'

            element :premium, String, tag: 'InsurancePremium'

            def self.domain_to_mapper(non_esi_policy)
              mapper = self.new
              mapper.member = non_esi_policy.member
              mapper.applied_effective_date_range = non_esi_policy.applied_effective_date_range
              mapper.identification = non_esi_policy.identification
              mapper.source_code = non_esi_policy.source_code
              mapper.premium = non_esi_policy.premium
              mapper
            end

            def to_hash
              {
                member: member,
                applied_effective_date_range: applied_effective_date_range,
                identification: identification&.to_hash,
                source_code: source_code,
                premium: premium
              }
            end
          end
        end
      end
    end
  end
end