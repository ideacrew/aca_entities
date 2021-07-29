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

            has_one :member, InsuranceMember

            has_one :applied_effective_date_range, InsurancePolicyAppliedEffectiveDateRange

            has_one :identification, InsurancePolicyIdentification

            # A source that offers insurance policies
            element :source_code, String, tag: 'InsurancePolicySourceCode'

            has_one :premium, InsurancePremium

            def self.domain_to_mapper(nep)
              mapper = self.new
              mapper.member = InsuranceMember.domain_to_mapper(nep.member)
              mapper.applied_effective_date_range = InsurancePolicyAppliedEffectiveDateRange.domain_to_mapper(nep.applied_effective_date_range)
              mapper.identification = InsurancePolicyIdentification.domain_to_mapper(nep.identification)
              mapper.source_code = nep.source_code
              mapper.premium = InsurancePremium.domain_to_mapper(nep.premium)
              mapper
            end

            def to_hash
              {
                member: member&.to_h,
                identification: identification&.to_h,
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