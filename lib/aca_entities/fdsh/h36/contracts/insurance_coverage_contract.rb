# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 InsuranceCoverageContract
        class InsuranceCoverageContract < Dry::Validation::Contract
          params do
            required(:ApplicableCoverageMonthNum).filled(:string)
            required(:QHPPolicyNum).filled(:string)
            required(:QHPIssuerEIN).filled(:string)
            required(:IssuerNm).filled(:string)
            required(:PolicyCoverageStartDt).filled(:date)
            optional(:PolicyCoverageEndDt).maybe(:date)
            required(:TotalQHPMonthlyPremiumAmt).filled(:float)
            required(:APTCPaymentAmt).filled(:float)
            required(:CoveredIndividuals).array(AcaEntities::Fdsh::H36::Contracts::CoveredIndividualContract.params)
            optional(:SLCSPMonthlyPremiumAmt).maybe(:float)
          end
        end
      end
    end
  end
end