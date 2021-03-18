# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Annual income information contract
      class AnnualIncomeInformationContract < Dry::Validation::Contract

        params do
          optional(:attested_annual_income_next_year).maybe(:float)
          optional(:attested_annual_income_this_year).maybe(:float)
          optional(:unknown_income).maybe(:string)
          optional(:variable_income).maybe(:string)
          optional(:estimated_annual_income_for_aptc).maybe(:float)
        end
      end
    end
  end
end
