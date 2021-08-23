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

              element :IncomeMonthYear, String, tag: 'IncomeMonthYear', namespace: "extn"
              element :BenefitCreditedAmount, Float, tag: 'BenefitCreditedAmount', namespace: "extn"
              element :OverpaymentDeductionAmount, Float, tag: 'OverpaymentDeductionAmount', namespace: "extn"
              element :PriorMonthAccrualAmount, Float, tag: 'PriorMonthAccrualAmount', namespace: "extn"
              element :ReturnedCheckAmount, Float, tag: 'ReturnedCheckAmount', namespace: "extn"
              element :PaymentInSuspenseIndicator, Boolean, tag: 'PaymentInSuspenseIndicator', namespace: "extn"

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