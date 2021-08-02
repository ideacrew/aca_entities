# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # response.
            class RequestedMonthInformation
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'RequestedMonthInformation'
              namespace 'extn'

              attribute :IncomeMonthYear, String, tag: 'IncomeMonthYear', namespace: "extn"
              attribute :BenefitCreditedAmount, BigDecimal, tag: 'BenefitCreditedAmount', namespace: "extn"
              attribute :OverpaymentDeductionAmount, BigDecimal, tag: 'OverpaymentDeductionAmount', namespace: "extn"
              attribute :PriorMonthAccrualAmount, BigDecimal, tag: 'PriorMonthAccrualAmount', namespace: "extn"
              attribute :ReturnedCheckAmount, BigDecimal, tag: 'ReturnedCheckAmount', namespace: "extn"
              attribute :PaymentInSuspenseIndicator, Boolean, tag: 'PaymentInSuspenseIndicator', namespace: "extn"

              def self.domain_to_mapper(initial_response)
                mapper = self.new

                mapper.IncomeMonthYear = initial_response.IncomeMonthYear
                mapper.BenefitCreditedAmount = initial_response.BenefitCreditedAmount
                mapper.OverpaymentDeductionAmount = initial_response.OverpaymentDeductionAmount
                mapper.PriorMonthAccrualAmount = initial_response.PriorMonthAccrualAmount
                mapper.ReturnedCheckAmount = initial_response.ReturnedCheckAmount
                mapper.PaymentInSuspenseIndicator = initial_response.PaymentInSuspenseIndicator

                mapper
              end
            end
          end
        end
      end
    end
  end
end