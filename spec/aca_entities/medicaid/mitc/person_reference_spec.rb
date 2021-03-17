# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mitc/types'
require 'aca_entities/medicaid/mitc/person_reference'

RSpec.describe ::AcaEntities::Medicaid::Mitc::PersonReference do
  describe 'with valid arguments' do
    let(:input_params) { { person_id: 100 } }

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a ::AcaEntities::Medicaid::Mitc::PersonReference
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
