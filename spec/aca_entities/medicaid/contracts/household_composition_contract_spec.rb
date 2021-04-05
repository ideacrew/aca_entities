# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/household_composition_contract'

RSpec.describe AcaEntities::Medicaid::Contracts::HouseholdCompositionContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    {
      medicaid_household_size: 3,
      qualified_children_list: 'Sansa, Stark'
    }
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
