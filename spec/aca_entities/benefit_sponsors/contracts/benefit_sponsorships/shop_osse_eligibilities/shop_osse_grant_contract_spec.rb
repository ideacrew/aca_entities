# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::ShopOsseGrantContract do
  let(:key) { :hc4cc }
  let(:title) { "childcare subsidy" }
  let(:value) { { title: title, key: key } }
  let(:description) { "childcare subsidy eligibility" }
  let(:required_params) { { key: key, title: title, value: value } }
  let(:optional_params) { { description: description } }

  let(:optional_params) do
    {
      event: "mark_eligible",
      comment: "hc4cc eligibility submitted",
      reason: "childcare subsidy"
    }
  end

  let(:error_message) { { value: ["is missing"] } }

  let(:result) { double(success?: true) }

  context "Given invalid required parameters" do
    context "sending with missing parameters should fail validation with :errors" do
      let(:invalid_params) { required_params.except(:value) }
      it { expect(subject.call(invalid_params).failure?).to be_truthy }
      it do
        expect(subject.call(invalid_params).errors.to_h).to eq error_message
      end
    end

    context "when value passed is invalid" do
      context "it should fail validation" do
        let(:value) { { title: title } }
        let(:invalid_params) { required_params }
        let(:error_message) { { value: { key: ["is missing"] } } }

        it { expect(subject.call(invalid_params).failure?).to be_truthy }
        it do
          expect(subject.call(invalid_params).errors.to_h).to eq error_message
        end
      end
    end
  end

  context "Given valid required parameters" do
    context "with a required only" do
      it "should pass validation" do
        expect(subject.call(required_params).success?).to be_truthy
        expect(subject.call(required_params).to_h).to eq required_params
      end
    end
  end
end
