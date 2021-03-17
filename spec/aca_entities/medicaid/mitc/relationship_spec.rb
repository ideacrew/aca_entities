# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mitc/types'
require 'aca_entities/medicaid/mitc/relationship'

RSpec.describe ::AcaEntities::Medicaid::Mitc::Relationship do
  describe 'with valid arguments' do
    let(:input_params) do
      { other_id: 100, attest_primary_responsibility: 'Y', relationship_code: '01' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a ::AcaEntities::Medicaid::Mitc::Relationship
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end
end
