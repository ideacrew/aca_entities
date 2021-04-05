# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/insurance_application_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::InsuranceApplicationContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    { application_metadta: { application_id: '12345' },
      attestation: { is_incarcerated: true } }
  end

  context 'success case' do
    before do
      @result = subject.call(input_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end
end
