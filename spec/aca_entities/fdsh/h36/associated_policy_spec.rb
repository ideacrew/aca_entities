# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/fdsh/h36/irs_household_coverage_shared_context'

RSpec.describe AcaEntities::Fdsh::H36::AssociatedPolicy, dbclean: :after_each do
  include_context('irs_group_coverage_shared_context')

  subject { described_class.new }

  let(:required_params) do
    associated_policy
  end

  describe 'with valid arguments' do
    it 'should initialize' do
      expect(described_class.new(required_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(required_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect do
        described_class.new(required_params.reject do |k, _v|
          k == :QHPPolicyNum
        end)
      end.to raise_error(Dry::Struct::Error, /:QHPPolicyNum is missing/)
    end
  end

end
