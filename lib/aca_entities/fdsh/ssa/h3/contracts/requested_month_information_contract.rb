# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class RequestedMonthInformationContract < Dry::Validation::Contract

          params do
            required(:IncomeMonthYear).filled(:string)
            required(:BenefitCreditedAmount).filled(:decimal)
            optional(:OverpaymentDeductionAmount).maybe(:decimal)
            optional(:PriorMonthAccrualAmount).maybe(:decimal)
            optional(:ReturnedCheckAmount).maybe(:decimal)
            required(:PaymentInSuspenseIndicator).filled(:bool)
          end
        end
      end
    end
  end
end