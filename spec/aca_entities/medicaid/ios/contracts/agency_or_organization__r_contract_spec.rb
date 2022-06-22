# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios'

RSpec.describe AcaEntities::Medicaid::Ios::Contracts::AgencyOrOrganizationRContract, dbclean: :after_each do

  let(:all_params) { { DCDataId__c: 0 } }

  context 'invalid parameters' do
    context 'with incorrect data type' do
      it 'should list error for every parameter' do
        bad_params = { DCDataId__c: "Id" }
        expect(subject.call(bad_params).errors.to_h.keys).to match_array all_params.keys
      end
    end
  end

  context 'valid parameters' do
    context 'with all required and optional parameters' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end