# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::RelationshipContract,  dbclean: :after_each do

  let(:applicant) do
    { first_name: 'first',
      last_name: 'last',
      dob: Date.today.prev_year.to_s,
      person_hbx_id: '95' }
  end
  let(:relative) do
    { first_name: 'first',
      last_name: 'last',
      dob: Date.today.prev_year.to_s,
      person_hbx_id: '96' }
  end
  let(:required_params) { { kind: "spouse", applicant_reference: applicant, relative_reference: relative } }
  let(:optional_params) { { lives_with_household_member: true } }
  let(:all_params) { required_params.merge(optional_params) }

  context "Given invalid parameter scenarios" do
    context "with empty parameters" do
      it 'should list error for every required parameter' do
        result = subject.call({})

        expect(result.success?).to be_falsey
        expect(result.errors.to_h.keys).to match_array required_params.keys
      end
    end
  end

  context "Given valid parameters" do
    context "and required parameters only" do
      it { expect(subject.call(required_params).success?).to be_truthy }
    end

    context "and all required and optional parameters" do
      it "should pass validation" do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
      end
    end
  end

  context 'domestic_partners_child and parents_domestic_partner' do
    before do
      input_params = { kind: ['domestic_partners_child', 'parents_domestic_partner'].sample,
                       applicant_reference: applicant,
                       relative_reference: relative }
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end
  end
end
