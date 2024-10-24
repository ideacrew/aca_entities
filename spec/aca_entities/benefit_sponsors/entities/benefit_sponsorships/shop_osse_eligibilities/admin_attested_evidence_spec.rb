# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::AdminAttestedEvidence do
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
  let(:subject_ref) do
    URI("gid://enroll_app/BenefitSponsors/BenefitSponsorship")
  end
  let(:evidence_ref) { URI("gid://enroll_app/BenefitSponsors/Evidence") }

  let(:required_params) do
    {
      key: key,
      title: title,
      is_satisfied: is_satisfied,
      current_state: :initial,
      state_histories: state_histories,
      evidence_ref: evidence_ref,
      subject_ref: subject_ref
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
