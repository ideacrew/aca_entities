# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/identifying_information_contract'

RSpec.describe ::AcaEntities::Contracts::IdentifyingInformationContract, dbclean: :after_each do

  let(:input_params) do
    { ssn: '123456789',
      hbx_id: '100',
      medicaid_id: 'medicaid_id',
      chip_id: 'chip_id',
      primary_insured: true,
      temporary_id: 'temporary_id' }
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
