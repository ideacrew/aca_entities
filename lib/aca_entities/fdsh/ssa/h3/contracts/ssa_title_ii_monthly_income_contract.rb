# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class SSATitleIIMonthlyIncomeContract < Dry::Validation::Contract

          params do
            required(:PersonDisabledIndicator).filled(:bool)
            required(:OngoingMonthlyBenefitCreditedAmount).filled(:decimal)
            required(:OngoingMonthlyOverpaymentDeductionAmount).filled(:decimal)
            required(:OngoingPaymentInSuspenseIndicator).filled(:bool)
            required(:RequestedMonthInformation).filled(AcaEntities::Fdsh::Ssa::H3::RequestedMonthInformationContract.params)
            required(:RequestedMonthMinusOneInformation).filled(AcaEntities::Fdsh::Ssa::H3::RequestedMonthInformationContract.params)
            required(:RequestedMonthMinusTwoInformation).filled(AcaEntities::Fdsh::Ssa::H3::RequestedMonthInformationContract.params)
            required(:RequestedMonthMinusThreeInformation).filled(AcaEntities::Fdsh::Ssa::H3::RequestedMonthInformationContract.params)
          end
        end
      end
    end
  end
end