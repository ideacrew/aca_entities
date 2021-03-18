# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/ssa_information_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::SsaInformationContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  context 'success case' do
    let(:input_params) do
      {
        is_person_alive: true,
        is_person_incarcerated: true,
        prisoner_confinement_date: Date.today,
        prison_name: 'Prison',
        prison_address: 'Same Location',
        ssn_verification_indicator: nil
      }
    end

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

  context 'failure case' do
    let(:input_params) do
      {
        is_person_alive: true,
        is_person_incarcerated: true,
        prisoner_confinement_date: Date.today,
        prison_name: 100,
        prison_address: 'Same Location'
      }
    end

    before do
      @result = subject.call(input_params)
    end

    it 'should return a failure with errors' do
      expect(@result.errors.to_h).to eq({ prison_name: ['must be a string'] })
    end
  end
end
