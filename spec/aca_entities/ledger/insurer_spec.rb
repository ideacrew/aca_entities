# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Ledger::Insurer do
  subject { described_class }

  let(:id) { '12345' }
  let(:hios_id) { '96667' }
  let(:name) { 'Healthcare Unlimited' }
  let(:description) { 'Statewide coverage' }

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { hios_id: hios_id } }
  let(:optional_params) { { id: id, name: name, description: description, timestamps: timestamps } }
  let(:all_params) { required_params.merge(optional_params) }

  describe 'with required arguments' do
    it 'should initialize' do
      expect(subject.new(required_params)).to be_a described_class
    end
  end

  describe 'Applying Comparable methods' do
    context 'and comparing two insurers with same attributes' do
      let(:insurer_1) { all_params }
      let(:insurer_2) { all_params }

      it 'they should be equal' do
        expect(described_class.new(insurer_1)).to eq described_class.new(insurer_2)
      end
    end

    context 'and comparing two insurers, one with different hios_id' do
      let(:insurer_1) { all_params }
      let(:insurer_2) { all_params.merge(hios_id: '90007') }

      it 'they should not be equal' do
        expect(described_class.new(insurer_1)).not_to eq described_class.new(insurer_2)
      end
    end
  end
end
