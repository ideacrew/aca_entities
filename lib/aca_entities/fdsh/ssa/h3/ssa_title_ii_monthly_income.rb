# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class SSATitleIIMonthlyIncome < Dry::Struct

          attribute :PersonDisabledIndicator,  Types::Bool.meta(omittable: true)
          attribute :OngoingMonthlyBenefitCreditedAmount,  Types::Decimal.optional.meta(omittable: true)
          attribute :OngoingMonthlyOverpaymentDeductionAmount,  Types::Decimal.optional.meta(omittable: true)
          attribute :OngoingPaymentInSuspenseIndicator,  Types::Bool.optional.meta(omittable: true)
          attribute :RequestedMonthInformation, AcaEntities::Fdsh::Ssa::H3::RequestedMonthInformation.optional.meta(omittable: true)
          attribute :RequestedMonthMinusOneInformation, AcaEntities::Fdsh::Ssa::H3::RequestedMonthInformation.optional.meta(omittable: true)
          attribute :RequestedMonthMinusTwoInformation, AcaEntities::Fdsh::Ssa::H3::RequestedMonthInformation.optional.meta(omittable: true)
          attribute :RequestedMonthMinusThreeInformation, AcaEntities::Fdsh::Ssa::H3::RequestedMonthInformation.optional.meta(omittable: true)
        end
      end
    end
  end
end