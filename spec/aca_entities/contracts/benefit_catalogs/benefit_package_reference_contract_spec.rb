# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::BenefitCatalogs::BenefitPackageReferenceContract, dbclean: :after_each do

  let(:required_params) do
    {
      title: 'test title',
      elected_premium_credit_strategy: 'unassisted'
    }
  end

  context 'success case' do
    before do
      @result = subject.call(required_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'missing required param' do
      before do
        @result = subject.call(required_params.reject { |k, _v| k == :elected_premium_credit_strategy })
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end

    context 'with bad input data type' do
      before do
        @result = subject.call(required_params.merge(elected_premium_credit_strategy: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be filled')
      end

      it 'should return error message' do
        result = subject.call(required_params.merge(elected_premium_credit_strategy: "test"))
        # rubocop:disable Layout/LineLength
        expect(result.errors.messages.first.text).to eq(
          'must be one of: unassisted, employer_fixed_cost, employee_fixed_cost, allocated_lump_sum_credit, percentage_contribution, indexed_percentage_contribution, federal_employee_health_benefit'
        )
        # rubocop:enable Layout/LineLength
      end
    end
  end
end

