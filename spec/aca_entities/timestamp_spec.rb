# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::TimeStamp, dbclean: :after_each do
  let(:input_params) { { submitted_at: DateTime.now, created_at: DateTime.now, modified_at: DateTime.now } }

  describe 'with valid arguments' do
    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { subject }.not_to raise_error
    end
  end

  describe 'Applying Comparable methods' do
    let(:yesterday) { DateTime.now - 1.day }
    let(:today) { DateTime.now }

    context 'and comparing two timestamps with same value' do
      let(:timestamp_1) { { submitted_at: today, created_at: today, modified_at: today } }
      let(:timestamp_2) { { submitted_at: today, created_at: today, modified_at: today } }

      it 'they should be equal' do
        expect(described_class.new(timestamp_1)).to eq described_class.new(timestamp_2)
      end
    end

    context 'and comparing two timestamps, one submitted after the other' do
      let(:timestamp_1) { { submitted_at: today, created_at: today, modified_at: today } }
      let(:timestamp_2) { { submitted_at: yesterday, created_at: yesterday, modified_at: yesterday } }

      it 'the one with later submitted_at should be greater than the other' do
        expect(described_class.new(timestamp_1)).to be > described_class.new(timestamp_2)
      end
    end

    context 'and comparing two timestamps without submitted_at value, one created after the other' do
      let(:timestamp_1) { { created_at: today, modified_at: today } }
      let(:timestamp_2) { { created_at: yesterday, modified_at: yesterday } }

      it 'the one with later updated_at should be should be greater than the other' do
        expect(described_class.new(timestamp_1)).to be > described_class.new(timestamp_2)
      end
    end

    context 'and comparing two timestamps without submitted_at value, and one updated after the other' do
      let(:timestamp_1) { { created_at: yesterday, modified_at: today } }
      let(:timestamp_2) { { created_at: yesterday, modified_at: yesterday } }

      it 'the one with later modified_at should be should be greater than the other' do
        expect(described_class.new(timestamp_1)).to be > described_class.new(timestamp_2)
      end
    end
  end
end
