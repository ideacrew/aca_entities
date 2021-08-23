# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class RequestedMonthInformation < Dry::Struct

          attribute :IncomeMonthYear,  Types::String.meta(omittable: false)
          attribute :BenefitCreditedAmount,  Types::Float.meta(omittable: false)
          attribute :OverpaymentDeductionAmount,  Types::Float.optional.meta(omittable: true)
          attribute :PriorMonthAccrualAmount,  Types::Float.optional.meta(omittable: true)
          attribute :ReturnedCheckAmount,  Types::Float.optional.meta(omittable: true)
          attribute :PaymentInSuspenseIndicator, Types::Bool.meta(omittable: false)

        end
      end
    end
  end
end