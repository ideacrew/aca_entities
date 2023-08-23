# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::People::IvlOsseEligibilities::AdminAttestedEvidence do
  let(:key) { :hc4cc }
  let(:title) { "childcare subsidy" }
  let(:is_satisfied) { true }
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
  let(:state_histories) do
    [AcaEntities::Eligible::StateHistory.new(history_params)]
  end

  let(:subject_ref) { URI("gid://enroll_app/People/Consumer") }
  let(:evidence_ref) { URI("gid://enroll_app/People/Evidence") }

  let(:required_params) do
    {
      key: key,
      title: title,
      current_state: :initial,
      is_satisfied: is_satisfied,
      state_histories: state_histories,
      subject_ref: subject_ref,
      evidence_ref: evidence_ref
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
