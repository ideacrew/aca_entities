# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for CurrentIncomeInformation.
    class CurrentIncomeInformationContract < Dry::Validation::Contract

      params do
        optional(:income_type_code).maybe(Iap::Types::IncomeType)
        optional(:income_type_amount).maybe(:float)
        optional(:income_frequency_code).maybe(Iap::Types::IncomeFrequency)
        optional(:days_per_week).maybe(:integer)
        optional(:hours_per_week).maybe(:integer)
        optional(:is_income_subject_to_federal_restrictions).maybe(:bool)
        optional(:employer_name).maybe(:string)
        optional(:employer_ein).maybe(:string)
        optional(:type_of_work).maybe(:string)
        optional(:unemployment_source).maybe(:string)
        optional(:date_unemployment_ends).maybe(:date)
      end

      rule(:income_type_code) do
        if key?
          # Required for PersonIncome elements that are conveying Pay Period Information.
        end
      end

      rule(:income_frequency_code) do
        if key?
          # Required if no IncomeDate in the PersonIncome, and it is not SSA-verified.
        end
      end

      rule(:days_per_week) do
        if key?
          # Required if Income Type Frequency Name is Daily.
        end
      end

      rule(:hours_per_week) do
        if key?
          # Required if Income Type Frequency Name is Hourly.
        end
      end

      rule(:type_of_work) do
        if key?
          # Required if Income Type Name is self-employment.
        end
      end
    end
  end
end
