# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class RequestedMonthInformation < Dry::Struct

          attribute :IncomeMonthYear,  Types::String.meta(omittable: false)
          attribute :BenefitCreditedAmount,  Types::Decimal.meta(omittable: false)
          attribute :OverpaymentDeductionAmount,  Types::Decimal.optional.meta(omittable: true)
          attribute :PriorMonthAccrualAmount,  Types::Decimal.optional.meta(omittable: true)
          attribute :ReturnedCheckAmount,  Types::Decimal.optional.meta(omittable: true)
          attribute :PaymentInSuspenseIndicator, Types::Bool.meta(omittable: false)

        end
      end
    end
  end
end