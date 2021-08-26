# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class SSACompositeIndividualRequestContract < Dry::Validation::Contract

          params do
            required(:Person).filled(AcaEntities::Fdsh::Ssa::H3::PersonContract.params)
            required(:RequestCitizenshipVerificationIndicator).filled(:bool)
            required(:RequestIncarcerationVerificationIndicator).filled(:bool)
            required(:RequestTitleIIMonthlyIncomeVerificationIndicator).filled(:bool)
            required(:RequestTitleIIAnnualIncomeVerificationIndicator).filled(:bool)
            required(:RequestQuartersOfCoverageVerificationIndicator).filled(:bool)
            optional(:RequestTitleIIMonthlyIncomeDate).maybe(:date)
            optional(:RequestTitleIIAnnualIncomeDate).maybe(:date)
          end
        end
      end
    end
  end
end
