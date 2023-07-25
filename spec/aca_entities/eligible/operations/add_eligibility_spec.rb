# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::Eligible::AddEligibility do
  let(:state_histories) do
    [AcaEntities::Eligible::StateHistory.new(history_params)]
  end

  let(:history_params) do
    {
      effective_on: Date.today,
      is_eligible: true,
      from_state: :draft,
      to_state: :eligible,
      event: :move_to_eligible,
      transition_at: DateTime.now
    }
  end

  let(:evidence_params) do
    [
      {
        key: :shop_osse_evidence,
        title: "childcare subsidy",
        is_satisfied: true,
        description: "childcare subsidy evidence",
        state_histories: state_histories
      }
    ]
  end

  let(:grant_params) do
    [
      {
        key: :min_employee_participation_relaxed_grant,
        title: "minimum employee rule relaxed ",
        description: "relaxed minimum number of employees",
        value:
          AcaEntities::Eligible::Value.new(
            title: "minimum employee rule relaxed",
            key: :min_employee_relaxed
          ).to_h,
        state_histories: state_histories
      }
    ]
  end

  let(:eligibility_params) do
    {
      key: :shop_osse_eligibility,
      title: "childcare subsidy",
      description: "childcare subsidy eligibility",
      state_histories: state_histories,
      evidences: evidence_params,
      grants: grant_params
    }
  end

  let(:required_params) do
    {
      subject:
        "AcaEntities::BenefitSponsors::BenefitSponsorships::BenefitSponsorship",
      eligibility: eligibility_params
    }
  end

  context "Initializing with required params" do
    it "should initialize the entity" do
      result = subject.call(required_params)

      expect(result).to be_success
      expect(
        result.value!
      ).to be_a AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::ShopOsseEligibility
    end

    it "should create evidence and grant" do
      result = subject.call(required_params)

      eligibility = result.value!
      expect(
        eligibility.evidences.first
      ).to be_a AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::AdminAttestedEvidence
      expect(
        eligibility.grants.first
      ).to be_a AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::ShopOsseGrant
    end
  end
end
