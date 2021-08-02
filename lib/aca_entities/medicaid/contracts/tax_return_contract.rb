# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for TaxReturn
      class TaxReturnContract < Dry::Validation::Contract

        params do
          optional(:total_exemptions_quantity).maybe(:integer)
          optional(:status_code).maybe(:string)
          optional(:tax_return_year).maybe(:integer)
          optional(:tax_household).maybe(:hash)
          optional(:tax_return_includes_dependent_indicator).maybe(:bool)
        end

        # rule(:tax_household_composition) do
        #   if key? && value
        #     if value.is_a?(Hash)
        #       result = HouseholdIncomeContract.new.call(value)
        #       if result&.failure?
        #         key.failure(text: 'invalid tax household composition', error: result.errors.to_h)
        #       else
        #         values.merge!(tax_household_composition: result.to_h)
        #       end
        #     else
        #       key.failure(text: 'invalid tax household composition. Expected a hash.')
        #     end
        #   end
        # end

        # rule(:annual_income_information) do
        #   if key? && value
        #     if value.is_a?(Hash)
        #       result = AnnualIncomeInformationContract.new.call(value)
        #       if result&.failure?
        #         key.failure(text: 'invalid annual income information', error: result.errors.to_h)
        #       else
        #         values.merge!(annual_income_information: result.to_h)
        #       end
        #     else
        #       key.failure(text: 'invalid annual income information. Expected a hash.')
        #     end
        #   end
        # end

        # rule(:irs_information) do
        #   if key? && value
        #     if value.is_a?(Hash)
        #       result = IrsInformationContract.new.call(value)
        #       if result&.failure?
        #         key.failure(text: 'invalid irs information', error: result.errors.to_h)
        #       else
        #         values.merge!(irs_information: result.to_h)
        #       end
        #     else
        #       key.failure(text: 'invalid irs information. Expected a hash.')
        #     end
        #   end
        # end

        # rule(:tax_household_annual_income) do
        #   if key? && value
        #     if value.is_a?(Hash)
        #       result = TaxHouseholdAnnualIncomeContract.new.call(value)
        #       if result&.failure?
        #         key.failure(text: 'invalid tax household annual income', error: result.errors.to_h)
        #       else
        #         values.merge!(tax_household_annual_income: result.to_h)
        #       end
        #     else
        #       key.failure(text: 'invalid tax household annual income. Expected a hash.')
        #     end
        #   end
        # end
      end
    end
  end
end
