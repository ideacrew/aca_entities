# frozen_string_literal: true

module AcaEntities
  # rubocop:disable Layout/LineLength
  class Applicant < Dry::Struct

    attribute :person_name, PersonName.meta(omittable: false)
    attribute :addresses, Types::Array.of(Address).optional.meta(omittable: true)
    attribute :demographic, Demographic.meta(omittable: false)
    attribute :identifying_information, IdentifyingInformation.optional.meta(omittable: true)
    attribute :identifying_numbers_from_documents, Types::Array.of(IdentifyingNumbersFromDocument).optional.meta(omittable: true)
    attribute :citizenship_immigration_status_information, CitizenshipImmigrationStatusInformation.meta(omittable: false)
    attribute :immigration_document, ImmigrationDocument.optional.meta(omittable: true)
    attribute :native_american_information, NativeAmericanInformation.meta(omittable: false)
    attribute :employer_sponsored_insurance_information, EmployerSponsoredInsuranceInformation.optional.meta(omittable: true)
    attribute :lowest_cost_plan, LowestCostPlan.optional.meta(omittable: true)
    attribute :current_income, CurrentIncome.optional.meta(omittable: true)
    attribute :ssa_income_information, SsaIncomeInformation.optional.meta(omittable: true)
    attribute :ssa_information, SsaInformation.optional.meta(omittable: true)
    attribute :ssa_work_quarters, Types::Array.of(SsaWorkQuarter).optional.meta(omittable: true)
    attribute :medicaid_specific_information, MedicaidSpecificInformation.optional.meta(omittable: true)
    attribute :other_insurance_coverage_information, OtherInsuranceCoverageInformation.optional.meta(omittable: true)
    attribute :other_insurance_details, Types::Array.of(OtherInsuranceDetail).optional.meta(omittable: true)
    attribute :person_description_identifiers, Types::Array.of(PersonDescriptionIdentifier).optional.meta(omittable: true)
    attribute :attestation, Attestation.optional.meta(omittable: true)
    attribute :dhs_save, DhsSave.optional.meta(omittable: true)
    attribute :coverage_specific_information, CoverageSpecificInformation.optional.meta(omittable: true)
    attribute :coverage_period, CoveragePeriod.optional.meta(omittable: true)
    attribute :relationships, Types::Array.of(Relationship).optional.meta(omittable: true)
    attribute :foster_care, FosterCare.optional.meta(omittable: true)
    attribute :basis_for_outcome, BasisForOutcome.optional.meta(omittable: true)
  end
  # rubocop:enable Layout/LineLength
end
