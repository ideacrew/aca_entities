# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::People::IvlOsseEligibilities::IvlOsseEligibility do
  let(:key) { :hc4cc }
  let(:title) { "childcare subsidy" }
  let(:description) { "childcare subsidy eligibility" }
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

  let(:subject_ref) { URI("gid://enroll_app/People/Consumer") }
  let(:evidence_ref) { URI("gid://enroll_app/People/Evidence") }

  let(:evidence_params) do
    [
      {
        key: :shop_osse_evidence,
        title: "childcare subsidy",
        is_satisfied: true,
        description: "childcare subsidy evidence",
        state_histories: state_histories,
        subject_ref: subject_ref,
        evidence_ref: evidence_ref
      }
    ]
  end

  let(:grant_params) do
    [
      {
        key: :premium_subsidy_grant,
        title: "Premium subsidy grant",
        description: "extra subsidy for osse eligible consumers",
        value:
          AcaEntities::Eligible::Value.new(
            title: "premium grant",
            key: :premium_subsidy_grant
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
