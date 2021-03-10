# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/contracts/navigator_contract'

RSpec.describe AcaEntities::Contracts::NavigatorContract, type: :model do

  it 'should be a container-ready operation' do
    expect(subject.respond_to?(:call)).to be_truthy
  end

  let(:input_params) do
    {
      first_name: nil,
      middle_name: nil,
      last_name: 'Assister',
      suffix: nil,
      organization_name: nil,
      organization_id: nil,
      broker_user_id: nil,
      broker_npn: nil,
      designation_date: Date.today.to_date
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

  context 'failure case' do
    context 'invalid input for designation_date' do
      before do
        @result = subject.call(input_params.merge(designation_date: Date.today.next_year))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message as start date' do
        expect(@result.errors.messages.first.text).to eq('Designation date is invalid')
      end
    end
  end
end
