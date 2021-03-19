# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/relationship'

RSpec.describe ::AcaEntities::MagiMedicaid::Relationship, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        kind: 'spouse',
        applicant_id: '100',
        relative_id: '101'
      }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:kind is missing in Hash input/)
    end
  end
end
