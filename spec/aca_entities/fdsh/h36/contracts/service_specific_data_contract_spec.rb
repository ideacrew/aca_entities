# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Fdsh::H36::Contracts::ServiceSpecificDataContract, dbclean: :after_each do
  subject { described_class.new }

  let(:required_params) do
    {
      ReportPeriod: {
        YearMonth: '2023-01'
      }
    }
  end

  context 'success case' do
    context 'with params passed' do
      it 'should return success' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
      end
    end
  end

  context 'failure case' do
    context 'with no params passed' do
      it 'should return success' do
        result = subject.call({})
        expect(result.failure?).to be_truthy
      end
    end
  end
end