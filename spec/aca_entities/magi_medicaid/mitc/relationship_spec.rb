# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::Relationship do
  describe 'with valid arguments' do
    let(:relationship) do
      { other_id: 101,
        attest_primary_responsibility: 'Y',
        relationship_code: '01' }
    end

    before do
      contract_params = ::AcaEntities::MagiMedicaid::Mitc::Contracts::RelationshipContract.new.call(relationship).to_h
      @result = described_class.new(contract_params)
    end

    it 'should return relationship entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of relationship' do
      expect(@result.to_h.keys).to eq(relationship.keys)
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end
end
