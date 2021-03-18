# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for HouseholdMember
      class HouseholdMember < Dry::Struct
        attribute :person_name, PersonName.meta(omittable: false)
        attribute :identifying_information, IdentifyingInformation.optional.meta(omittable: true)
        attribute :demographic, Demographic.meta(omittable: false)
        attribute :pregnancy_information, PregnancyInformation.optional.meta(omittable: true)
        attribute :current_income_information, CurrentIncomeInformation.optional.meta(omittable: true)
        attribute :current_deduction_information, CurrentDeductionInformation.optional.meta(omittable: true)
        attribute :current_income, CurrentIncome.optional.meta(omittable: true)
        attribute :current_income_employer, CurrentIncomeEmployer.optional.meta(omittable: true)
        attribute :pay_period_information, PayPeriodInformation.optional.meta(omittable: true)
        attribute :relationships, Types::Array.of(Relationship).meta(omittable: false)
      end
    end
  end
end
