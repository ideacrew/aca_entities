# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/exchange_eligibility_header_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::ExchangeEligibilityHeaderContract,  dbclean: :around_each do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:required_params) do
    {
      start_date: Date.today,
      medicaid_chip_state: 'DC'
    }
  end

  let(:all_params) do
    required_params.merge(
      eligibility_indicator: true,
      determination_date: DateTime.now,
      end_date: Date.today,
      medicaid_chip_county: "Washington",
      eligibility_establishment_system: "enroll_system"
    )
  end

  context 'success case' do
    it 'should return success without any errors when required params passed' do
      result = subject.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.errors.empty?).to be_truthy
    end

    it 'should return success without any errors when all params passed' do
      result = subject.call(all_params)
      expect(result.success?).to be_truthy
      expect(result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'without all required params' do

      it 'should return failure with errors' do
        result = subject.call({ start_date: Date.today })
        expect(result.failure?).to be_truthy
        expect(result.errors.empty?).to be_falsy
        expect(result.errors.to_h).to eq({ :medicaid_chip_state => ["is missing"] })
      end
    end

    context 'invalid input for start_date' do
      it 'should return failure with error message' do
        result = subject.call(required_params.merge(start_date: ''))
        expect(result.failure?).to be_truthy
        expect(result.errors.empty?).to be_falsy
        expect(result.errors.to_h).to eq({ :start_date => ["must be filled"] })
      end
    end

    context 'invalid input for end_date' do
      it 'should return error message' do
        result = subject.call(required_params.merge(end_date: "end date"))
        expect(result.errors.to_h).to eq({ :end_date => ["must be a date"] })
      end
    end
  end
end

