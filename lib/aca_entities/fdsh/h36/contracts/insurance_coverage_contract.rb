# frozen_string_literal: true

module AcaEntities
    module Fdsh
      module H36
        module Contracts
          # Contract for H36 InsuredPersonContract
          class InsuranceCoverageContract < Dry::Validation::Contract
            params do
              required(:ApplicableCoverageMonthNum).filled(:string)
              required(:QHPPolicyNum).filled(:string)
              required(:QHPIssuerEIN).filled(:string)
              required(:IssuerNm).filled(:string)
              required(:PolicyCoverageStartDt).filled(:date)
              required(:PolicyCoverageEndDt).filled(:date)
              required(:TotalQHPMonthlyPremiumAmt).filled(:float)
              required(:APTCPaymentAmt).filled(:float)
              required(:CoveredIndividual).filled(AcaEntities::Fdsh::H36::Contracts::InsuredPersonContract.params)
              required(:CoverageStartDt).filled(:date)
              required(:CoverageEndDt).filled(:date)
            end
          end
        end
      end
    end
  end