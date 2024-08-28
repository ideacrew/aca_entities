# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::PvpEligibilities::PvpEligibility do
  let(:key) { :pvp_eligibility }
  let(:title) { "pvp eligibility" }
  let(:description) { "premium value product eligibility" }
  let(:history_params) do
    {
      effective_on: Date.today,
      is_eligible: true,
      from_state: :draft,
      to_state: :eligible,
      event: :move_to_eligible,
      transition_at: DateTime.now,
      updated_by: "gid://enroll/User/66c4f31a90be7cedfb877fe7"
    }
  end

  let(:subject_ref) { URI("gid://enroll_app/People/Consumer") }
  let(:evidence_ref) { URI("gid://enroll_app/People/Evidence") }

  let(:evidence_params) do
    [
      {
        key: :shop_pvp_evidence,
        title: "pvp evidence",
        is_satisfied: true,
        current_state: :initial,
        description: "premium value product evidence",
        state_histories: state_histories,
        subject_ref: subject_ref,
        evidence_ref: evidence_ref
      }
    ]
  end

  let(:grant_params) do
    [
      {
        key: :pvp_grant,
        title: "Premium subsidy grant",
        description: "epremium value product grants",
        value:
          AcaEntities::Eligible::Value.new(
            title: "premium grant",
            key: :pvp_grant
          ).to_h
      }
    ]
  end

  let(:state_histories) do
    [AcaEntities::Eligible::StateHistory.new(history_params)]
  end

  let(:required_params) do
    {
      key: key,
      title: title,
      current_state: :initial,
      state_histories: state_histories,
      evidences: evidence_params,
      grants: grant_params
    }
  end

  let(:optional_params) { { description: description } }

  let(:all_params) { required_params.merge(optional_params) }

  context "Initializing with required params" do
    it "should initialize the entity" do
      result = described_class.new(required_params)

      expect(result).to be_a described_class
    end
  end

  context "initializing with additional optional params" do
    it "should initialize the entity" do
      result = described_class.new(all_params)

      expect(result).to be_a described_class
    end
  end
end
