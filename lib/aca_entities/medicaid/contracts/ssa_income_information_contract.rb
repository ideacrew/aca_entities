# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for SsaIncomeInformation.
      class SsaIncomeInformationContract < Dry::Validation::Contract

        params do
          optional(:annual_title_ii_income).maybe(:float)
          optional(:monthly_title_ii_income).maybe(:float)
          optional(:title_ii_income_month).maybe(:date)
          optional(:title_ii_income_year).maybe(:date)
        end
      end
    end
  end
end
