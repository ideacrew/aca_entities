# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/contracts/relationship_contract'

RSpec.describe AcaEntities::MagiMedicaid::Contracts::RelationshipContract,  dbclean: :after_each do

  let(:required_params) { { kind: "spouse", applicant_id: '100', relative_id: '101' } }

  let(:all_params) { required_params }

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
      it { expect(subject.call(required_params).to_h).to eq required_params }
    end

    context "and all required and optional parameters" do
      it "should pass validation" do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end
