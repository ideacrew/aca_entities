# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an InsuranceCoverage.
          class InsuranceCoverage
            include HappyMapper

            tag 'InsuranceCoverage'

            element :ApplicableCoverageMonthNum, String, tag: "ApplicableCoverageMonthNum"
            element :QHPPolicyNum, String, tag: "QHPPolicyNum"
            element :QHPIssuerEIN, String, tag: "QHPIssuerEIN"
            element :IssuerNm, String, tag: "IssuerNm"
            element :PolicyCoverageStartDt, String, tag: "PolicyCoverageStartDt"
            element :PolicyCoverageEndDt, String, tag: "PolicyCoverageEndDt"
            element :TotalQHPMonthlyPremiumAmt, String, tag: "TotalQHPMonthlyPremiumAmt"
            element :APTCPaymentAmt, String, tag: "APTCPaymentAmt"
            has_many :CoveredIndividuals, CoveredIndividual
            element :SLCSPMonthlyPremiumAmt, String, tag: "SLCSPMonthlyPremiumAmt"

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.ApplicableCoverageMonthNum = request.ApplicableCoverageMonthNum
              mapper.QHPPolicyNum = request.QHPPolicyNum
              mapper.QHPIssuerEIN = request.QHPIssuerEIN
              mapper.IssuerNm = request.IssuerNm
              mapper.PolicyCoverageStartDt = request.PolicyCoverageStartDt
              mapper.PolicyCoverageEndDt = request.PolicyCoverageEndDt
              mapper.TotalQHPMonthlyPremiumAmt = format('%.2f', request.TotalQHPMonthlyPremiumAmt)
              mapper.APTCPaymentAmt = format('%.2f', request.APTCPaymentAmt)
              mapper.CoveredIndividuals = request.CoveredIndividuals.collect do |covered_individual|
                CoveredIndividual.domain_to_mapper(covered_individual)
              end
              mapper.SLCSPMonthlyPremiumAmt = format('%.2f', request.SLCSPMonthlyPremiumAmt) if request.SLCSPMonthlyPremiumAmt

              mapper
            end
          end
        end
      end
    end
  end
end