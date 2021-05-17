# frozen_string_literal: true

require "spec_helper"

RSpec.describe AcaEntities::BenefitMarkets::Locations::ServiceAreaContract do

  let(:active_year)             { Date.today.year }
  let(:issuer_provided_title)   { 'Issuer Provided Title' }
  let(:issuer_provided_code)    { 'Issuer Provided Code' }
  let(:issuer_profile_reference) do
    {
      hbx_id: '1234', fein: '123333333', hbx_carrier_id: '333333',
      name: 'Delta Dental', abbrev: 'DDPA'
    }
  end
  let(:issuer_hios_id)          { :hios_id }
  let(:county_zip_ids)          { [{}] }
  let(:covered_states)          { ['DC'] }

  let(:missing_params) do
    {
      active_year: active_year,
      issuer_provided_title: issuer_provided_title,
      issuer_provided_code: issuer_provided_code,
      county_zip_ids: county_zip_ids,
      covered_states: covered_states
    }
  end

  let(:service_area) do
    {
      active_year: 2020, issuer_hios_id: :hios_id,
      issuer_provided_title: 'Issuer Provided Title',
      issuer_provided_code: 'Issuer Provided code',
      county_zip_ids: [{}], covered_states: ['DC'],
      issuer_profile_reference: issuer_profile_reference
    }
  end

  let(:invalid_params)      { missing_params.merge({ issuer_profile_reference: issuer_profile_reference, issuer_hios_id: :issuer_hios_id }) }
  let(:error_message1)      { { :issuer_profile_reference => ["is missing"] } }
  let(:error_message2)      { { :issuer_hios_id => ["must be a string"] } }

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
      let(:required_params)     { missing_params.merge({ issuer_profile_reference: issuer_profile_reference, issuer_hios_id: issuer_hios_id.to_s }) }

      it "should pass validation" do
        expect(subject.call(required_params).success?).to be_truthy
        expect(subject.call(required_params).to_h).to eq required_params
      end
    end
  end
end