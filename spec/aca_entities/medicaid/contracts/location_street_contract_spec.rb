# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/location_street_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::LocationStreetContract do

  let(:required_params) { {} }

  let(:optional_params) { { street_full_text: "123 Easy Street" } }

  let(:all_params) { required_params.merge(optional_params)}

  context 'valid parameters' do
    context 'with optional parameters only' do

      before do
        @result = subject.call(optional_params)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.to_h).to eq optional_params }
    end

    context 'with all required and optional parameters' do
      it 'should pass validation' do

        result = subject.call(all_params)

        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end
