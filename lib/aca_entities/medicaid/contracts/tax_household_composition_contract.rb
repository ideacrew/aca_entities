# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for TaxHouseholdComposition
      class TaxHouseholdCompositionContract < Dry::Validation::Contract

        params do
          optional(:tax_household_size_change_expected).maybe(:bool)
          optional(:tax_filer_indicator).maybe(:string)
          optional(:dependent_indicator).maybe(:string)
          optional(:claims_dependent_indicator).maybe(:bool)
          optional(:married_filing_jointly_code).maybe(:string)
          optional(:member_of_applicant_tax_household).maybe(:string)
          optional(:custodial_claiming_tax_filer).maybe(:bool)
        end
      end
    end
  end
end
