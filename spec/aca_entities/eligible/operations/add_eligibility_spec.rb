# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::Eligible::AddEligibility do
  let(:eligibility_state_histories) do
    [AcaEntities::Eligible::StateHistory.new(eligibility_history_params)]
  end

  let(:eligibility_history_params) do
    {
      effective_on: Date.today,
      is_eligible: true,
      from_state: :ineligible,
      to_state: :eligible,
      event: :move_to_eligible,
      transition_at: DateTime.now
    }
  end

  let(:evidence_state_histories) do
    [AcaEntities::Eligible::StateHistory.new(evidence_history_params)]
  end

  let(:evidence_history_params) do
    {
      effective_on: Date.today,
      is_eligible: true,
      from_state: :not_approved,
      to_state: :approved,
      event: :move_to_eligible,
      transition_at: DateTime.now
    }
  end

  let(:subject_ref) do
    URI("gid://enroll_app/BenefitSponsors/BenefitSponsorship")
  end

  let(:evidence_ref) { URI("gid://enroll_app/BenefitSponsors/Evidence") }

  let(:evidence_params) do
    [
      {
        key: :shop_osse_evidence,
        title: "childcare subsidy",
        is_satisfied: true,
        current_state: :initial,
        description: "childcare subsidy evidence",
        state_histories: evidence_state_histories,
        evidence_ref: evidence_ref,
        subject_ref: subject_ref
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
          ).to_h
      }
    ]
  end

  let(:eligibility_params) do
    {
      key: :shop_osse_eligibility,
      title: "childcare subsidy",
      current_state: :initial,
      description: "childcare subsidy eligibility",
      state_histories: eligibility_state_histories,
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

  context "when passed invalid params" do
    context "when invalid key passed" do
      it "should fail" do
        result = subject.call(required_params.except(:subject))

        expect(result).to be_failure
        expect(result.failure).to eq "subject is required"
      end
    end

    context "when invalid eligibility is_eligible passed" do
      let(:eligibility_history_params) do
        {
          effective_on: Date.today,
          is_eligible: false,
          from_state: :ineligible,
          to_state: :eligible,
          event: :move_to_eligible,
          transition_at: DateTime.now
        }
      end

      it "should fail" do
        result = subject.call(required_params)

        expect(result).to be_failure
        expect(result.failure).to include "is_eligible should be true for eligible state"
      end
    end

    context "when invalid eligibility event, to_state passed" do
      let(:eligibility_history_params) do
        {
          effective_on: Date.today,
          is_eligible: true,
          from_state: :draft,
          to_state: :initial,
          event: :move_to_eligible,
          transition_at: DateTime.now
        }
      end

      it "should fail" do
        result = subject.call(required_params)

        expect(result).to be_failure
        expect(result.failure).to include "event name should be move_to_initial"
        expect(
          result.failure
        ).to include "Invalid to state initial. It should be one of [:eligible, :ineligible]."
        expect(
          result.failure
        ).to include "is_eligible should be false for initial state"
      end
    end
  end
end
