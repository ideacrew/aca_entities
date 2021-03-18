# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/pregnancy_information_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::PregnancyInformationContract, dbclean: :after_each do

  let(:input_params) do
    { is_pregnant: true,
      expected_children_count: 2 }
  end

  context 'with all parameters' do
    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should return all the params' do
      expect(@result.to_h).to eq input_params
    end
  end
end
