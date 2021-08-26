# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::BenefitSponsorCatalogs::BenefitSponsorCatalogContract do

  let(:effective_date)          { Date.today.next_month }
  let(:effective_period)        { effective_date..effective_date.next_year.prev_day }
  let(:oe_start_on)             { Date.today}
  let(:open_enrollment_period)  { oe_start_on..(oe_start_on + 10) }
  let(:probation_period_kinds)  { [] }
  # let(:benefit_application)     { {} }

  let(:product_package)         { instance_double('BenefitMarkets::ProductPackage') }
  let(:product_packages)        { [product_package] }
  # let(:service_area_ids)        { [BSON::ObjectId.new] }

  let(:missing_params)          do
    { effective_date: effective_date, effective_period: effective_period, open_enrollment_period: open_enrollment_period }
  end
  let(:all_params)              { {} }

  let(:error_message) { { :probation_period_kinds => ["is missing"], :product_packages => ["is missing"] } }

  let(:result) { double(:success? => true) }

  context "Given invalid required parameters" do
    context "sending with missing parameters should fail validation with :errors" do
      it { expect(subject.call(missing_params).failure?).to be_truthy }
      it { expect(subject.call(missing_params).errors.to_h).to eq error_message }
    end
  end

  context "Given valid required parameters" do

    let(:required_params)     { missing_params.merge({ probation_period_kinds: probation_period_kinds, product_packages: product_packages }) }

    before do
      allow(product_package).to receive(:is_a?).with(AcaEntities::BenefitMarkets::ProductPackage) { true }
    end

    context "with a required only" do
      it "should pass validation" do
        expect(subject.call(required_params).success?).to be_truthy
        expect(subject.call(required_params).to_h).to eq required_params
      end
    end

    # context "with all params" do
    #   let(:all_params)          { required_params.merge({benefit_application: benefit_application}) }

    #   it "should pass validation" do
    #     expect(subject.call(all_params).success?).to be_truthy
    #     expect(subject.call(all_params).to_h).to eq all_params
    #   end
    # end
  end
end
