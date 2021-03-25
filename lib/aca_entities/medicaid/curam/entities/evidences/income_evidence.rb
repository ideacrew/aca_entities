# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Evidence
        # entity for income evidence
        class IncomeEvidence < Evidences::Evidence

          attribute :amount,                  Types::Decimal.meta(omittable: false)
          attribute :kind,                    Types::EvidenceIncomeTypeKind.meta(omittable: false)
          attribute :type_code,               Types::EvidenceTypeCodeKind.optional.meta(omittable: true)
          attribute :frequency,               Types::EvidenceIncomeFrequencyKind.meta(omittable: false)
          attribute :frequency_code,          Types::EvidenceFrequencyCodeKind.optional.meta(omittable: true)
          attribute :aggregate_id,            Types::String.optional.meta(omittable: true)

          attribute :start_date,              Types::Date.meta(omittable: false)
          attribute :end_date,                Types::Date.optional.meta(omittable: true)
          attribute :last_payment_date,       Types::Date.optional.meta(omittable: true)
          attribute :category,                Curam::TypesEvidenceCategoryKind.meta(omittable: false)
        end

        # class Evidences::BenefitEvidence < Evidences::Evidence
        # end

        # class Evidences::EarnedEvidence < Evidences::Evidence
        # end

        # class Evidences::UnEarnedEvidence < Evidences::Evidence
        # end

        # class Evidences::DeductionEvidence < Evidences::Evidence
        # end
      end
    end
  end
end
