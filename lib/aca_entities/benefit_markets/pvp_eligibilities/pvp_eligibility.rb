# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module PvpEligibilities
      class PvpEligibility < AcaEntities::Eligible::Eligibility

        evidence :pvp_evidence, class_name: "AcaEntities::BenefitMarkets::PvpEligibilities::AdminAttestedEvidence"

        grant :pvp_grant, class_name: "AcaEntities::BenefitMarkets::PvpEligibilities::PvpGrant"

      end
    end
  end
end