# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::Products::PremiumTableContract do

  let(:effective_date)      { Date.today.next_month }
  let(:effective_period)    { effective_date..(effective_date.next_year) }
  let(:premium_tuples)      { { age: 12, cost: 227.07 } }
  let(:rating_area_params)  { { county_zip_ids: [{}], exchange_provided_code: 'code', covered_states: [{}], active_year: 2020 } }

  let(:missing_params)      { { effective_period: effective_period, premium_tuples: [premium_tuples] } }
  let(:invalid_params)      { { premium_tuples: [premium_tuples], effective_period: effective_date, rating_area: rating_area_params } }
  let(:error_message1)      { { :rating_area => ["is missing"] } }
  let(:error_message2)      { { :effective_period => ["must be Range"] } }

  context "Given invalid required parameters" do
    context "sending with missing parameters should fail validation with errors" do
      it { expect(subject.call(missing_params).failure?).to be_truthy }
      it { expect(subject.call(missing_params).errors.to_h).to eq error_message1 }
    end

    context "sending with invalid parameters should fail validation with errors" do
      it { expect(subject.call(invalid_params).failure?).to be_truthy }
      it { expect(subject.call(invalid_params).errors.to_h).to eq error_message2 }
    end
  end

  context "Given valid required parameters" do
    context "with all params" do
      let(:required_params)  { missing_params.merge({ rating_area: rating_area_params }) }

      it "should pass validation" do
        expect(subject.call(required_params).success?).to be_truthy
        expect(subject.call(required_params).to_h).to eq required_params
      end
    end
  end
end