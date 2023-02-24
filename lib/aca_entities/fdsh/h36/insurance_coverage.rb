# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity InsuranceCoverage
      class InsuranceCoverage < Dry::Struct
        attribute :ApplicableCoverageMonthNum, AcaEntities::Types::String.optional.meta(omittable: false)
        attribute :QHPPolicyNum, AcaEntities::Types::String.optional.meta(omittable: false)
        attribute :QHPIssuerEIN, AcaEntities::Types::String.meta(omittable: false)
        attribute :IssuerNm, AcaEntities::Types::String.meta(omittable: false)
        attribute :PolicyCoverageStartDt,  AcaEntities::Types::Date.meta(omittable: false)
        attribute :PolicyCoverageEndDt,  AcaEntities::Types::Date.optional.meta(omittable: false)
        attribute :TotalQHPMonthlyPremiumAmt,  AcaEntities::Types::Float.meta(omittable: false)
        attribute :APTCPaymentAmt,  AcaEntities::Types::Float.meta(omittable: false)
        attribute :CoveredIndividuals,  Types::Array.of(AcaEntities::Fdsh::H36::CoveredIndividual).meta(omittable: false)
        attribute :SLCSPMonthlyPremiumAmt,  AcaEntities::Types::Float.optional.meta(omittable: true)
      end
    end
  end
end
