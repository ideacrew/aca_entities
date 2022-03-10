# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::People::PersonName, dbclean: :after_each do
  subject { described_class }

  let!(:params) do
    { first_name: 'Zaphod', middle_name: 'Xavier', last_name: 'Beeblebrox', name_pfx: 'Dr', name_sfx: 'Jr' }
  end

  describe 'with valid arguments' do
    it 'should initialize' do
      expect(subject.new(params)).to be_a subject
    end

    it 'should not raise error' do
      expect { subject.new(params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject.new(params.reject { |k, _v| k == :first_name }) }.to raise_error(
        Dry::Struct::Error,
        /:first_name is missing/
      )
    end
  end

  describe '#full_name' do
    let(:full_name) { 'Dr Zaphod Xavier Beeblebrox Jr' }
    it 'should return the full_name if not passed as parameter' do
      expect(subject.new(params).full_name).to eq full_name
    end
  end

  describe 'Applying Comparable methods' do
    let(:yesterday) { DateTime.now - 1.day }
    let(:today) { DateTime.now }

    context 'and comparing two names with same attributes' do
      let(:name_1) { { first_name: 'Zaphod', last_name: 'Beeblebrox' } }
      let(:name_2) { { first_name: 'Zaphod', last_name: 'Beeblebrox' } }

      it 'they should be equal' do
        expect(described_class.new(name_1)).to eq described_class.new(name_2)
      end
    end

    context 'aand comparing two names, one with different middle_name' do
      let(:name_1) { { first_name: 'Zaphod', midde_name: 'X', last_name: 'Beeblebrox' } }
      let(:name_2) { { first_name: 'Zaphod', middle_name: 'Xavier', last_name: 'Beeblebrox' } }

      it 'they should be equal' do
        expect(described_class.new(name_1)).to eq described_class.new(name_2)
      end
    end

    context 'and comparing two names, one with different first_name' do
      let(:name_1) { { first_name: 'Zaphod', last_name: 'Beeblebrox' } }
      let(:name_2) { { first_name: 'Harry', last_name: 'Beeblebrox' } }

      it 'they should not be equal' do
        expect(described_class.new(name_1)).not_to eq described_class.new(name_2)
      end
    end

    context 'and comparing two names, one with different last_name' do
      let(:name_1) { { first_name: 'Harry', last_name: 'Beeblebrox' } }
      let(:name_2) { { first_name: 'Harry', last_name: 'Dent' } }

      it 'they should not be equal' do
        expect(described_class.new(name_1)).not_to eq described_class.new(name_2)
      end
    end
  end
end
