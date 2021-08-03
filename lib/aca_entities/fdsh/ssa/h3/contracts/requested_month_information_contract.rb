# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class RequestedMonthInformationContract < Dry::Validation::Contract

          params do
            required(:IncomeMonthYear).filled(:string)
            required(:BenefitCreditedAmount).filled(:float)
            optional(:OverpaymentDeductionAmount).maybe(:float)
            optional(:PriorMonthAccrualAmount).maybe(:float)
            optional(:ReturnedCheckAmount).maybe(:float)
            required(:PaymentInSuspenseIndicator).filled(:bool)
          end
        end
      end
    end
  end
end