# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::Eligible::AddEvidence do
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
      event: :move_to_approved,
      transition_at: DateTime.now
    }
  end
  let(:subject_ref) do
    URI("gid://enroll_app/BenefitSponsors/BenefitSponsorship")
  end
  let(:evidence_ref) { URI("gid://enroll_app/BenefitSponsors/Evidence") }

  let(:evidence_key) { :shop_osse_evidence }
  let(:evidence_params) do
    [
      {
        key: evidence_key,
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
        key: :min_employee_relaxed_grant,
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

  let(:eligibility_key) { :shop_osse_eligibility }

  let(:eligibility_params) do
    {
      key: eligibility_key,
      title: "childcare subsidy",
      current_state: :initial,
      description: "childcare subsidy eligibility",
      state_histories: eligibility_state_histories,
      evidences: evidence_params,
      grants: grant_params
    }
  end

  let(:subject_klass) do
    "AcaEntities::BenefitSponsors::BenefitSponsorships::BenefitSponsorship"
  end

  let(:required_params) do
    {
      subject: subject_klass,
      eligibility: eligibility_params,
      evidence:
        evidence_params.first.merge(title: "childcare subsidy evidence2")
    }
  end

  context "Initializing with required params" do
    it "should return evidence and eligibility" do
      result = subject.call(required_params)

      expect(result).to be_success
      output = result.value!

      expect(
        output.first
      ).to be_a AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::AdminAttestedEvidence
      expect(
        output.last
      ).to be_a AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::ShopOsseEligibility
    end

    it "should return eligibility with newly added evidence" do
      result = subject.call(required_params)

      expect(result).to be_success
      output = result.value!

      eligibility = output.last
      expect(eligibility.evidences.count).to eq 2
      expect(eligibility.evidences.map(&:title)).to include(
        "childcare subsidy evidence2"
      )
    end
  end

  context "when different eligibility and evidence key are passed" do
    let(:eligibility_key) { :shop_osse }
    let(:evidence_key) { :evidence }

    it "should use default evidence class" do
      result = subject.call(required_params)

      expect(result.success?).to be_truthy

      output = result.success
      expect(output.first).to be_a AcaEntities::Eligible::Evidence
      expect(output.last).to be_a AcaEntities::Eligible::Eligibility
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

    context "when unknow class passed as subject" do
      let(:subject_klass) do
        "AcaEntities::BenefitSponsors::BenefitSponsorships::ShopBenefitSponsorship"
      end
      it "should return failure monad" do
        result = subject.call(required_params)

        expect(result).to be_failure
        expect(result.failure).to include(
          "uninitialized constant #{subject_klass}"
        )
      end
    end

    context "when invalid evidence event, to_state passed" do
      let(:evidence_history_params) do
        {
          effective_on: Date.today,
          is_eligible: true,
          from_state: :initial,
          to_state: :not_approved,
          event: :move_to_eligible,
          transition_at: DateTime.now
        }
      end

      it "should fail" do
        result = subject.call(required_params)

        expect(result).to be_failure
        expect(
          result.failure
        ).to include "event name should be move_to_not_approved"
        expect(
          result.failure
        ).to include "is_eligible should be false for not_approved state"
      end
    end
  end
end
