# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # response.
            class SSATitleIIMonthlyIncome
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'

              tag 'SSATitleIIMonthlyIncome'
              namespace 'extn'

              element :PersonDisabledIndicator, Boolean, tag: 'PersonDisabledIndicator', namespace: "extn"
              element :OngoingMonthlyBenefitCreditedAmount, Float, tag: 'OngoingMonthlyBenefitCreditedAmount', namespace: "extn"
              element :OngoingMonthlyOverpaymentDeductionAmount, Float, tag: 'OngoingMonthlyOverpaymentDeductionAmount', namespace: "extn"
              element :OngoingPaymentInSuspenseIndicator, Boolean, tag: 'OngoingPaymentInSuspenseIndicator', namespace: "extn"
              has_one :RequestedMonthInformation, RequestedMonthInformation
              has_one :RequestedMonthMinusOneInformation, RequestedMonthInformation
              has_one :RequestedMonthMinusTwoInformation, RequestedMonthInformation
              has_one :RequestedMonthMinusThreeInformation, RequestedMonthInformation

              def self.domain_to_mapper(initial_response)
                mapper = self.new

                mapper.PersonDisabledIndicator = initial_response.PersonDisabledIndicator
                mapper.OngoingMonthlyBenefitCreditedAmount = initial_response.OngoingMonthlyBenefitCreditedAmount
                mapper.OngoingMonthlyOverpaymentDeductionAmount = initial_response.OngoingMonthlyOverpaymentDeductionAmount
                mapper.OngoingPaymentInSuspenseIndicator = initial_response.OngoingPaymentInSuspenseIndicator
                mapper.RequestedMonthInformation = RequestedMonthInformation.domain_to_mapper(initial_response.RequestedMonthInformation)
                mapper.RequestedMonthMinusOneInformation = RequestedMonthInformation.domain_to_mapper(initial_response.RequestedMonthInformation)
                mapper.RequestedMonthMinusOneInformation = RequestedMonthInformation.domain_to_mapper(initial_response.RequestedMonthInformation)
                mapper.RequestedMonthMinusOneInformation = RequestedMonthInformation.domain_to_mapper(initial_response.RequestedMonthInformation)

                mapper
              end
            end
          end
        end
      end
    end
  end
end