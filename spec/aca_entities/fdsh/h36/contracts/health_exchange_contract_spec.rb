# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/fdsh/h36/irs_household_coverage_shared_context'

RSpec.describe AcaEntities::Fdsh::H36::Contracts::HealthExchangeContract, dbclean: :after_each do
  include_context('irs_group_coverage_shared_context')

  subject { described_class.new }

  let(:required_params) do
    {
      SubmissionYr: Date.today.year.to_s,
      SubmissionMonthNum: Date.today.month.to_s,
      ApplicableCoverageYr: Date.today.year.to_s,
      IndividualExchange: individual_exchange
    }
  end

  let(:error_messages) do
    { :SubmissionYr => ["is missing"],
      :SubmissionMonthNum => ["is missing"],
      :ApplicableCoverageYr => ["is missing"],
      :IndividualExchange => ["is missing"] }
  end

  context 'failure case' do
    context 'missing_required params' do
      it 'should return failure' do
        result = subject.call({})
        expect(result.failure?).to be_truthy
      end

      it 'should return error messages' do
        result = subject.call({})
        expect(result.errors.to_h).to eq error_messages
      end
    end
  end

  context 'success case' do
    context 'required params' do
      it 'should return success' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
      end
    end
  end
end
