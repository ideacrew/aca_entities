# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mitc/types'
require 'aca_entities/medicaid/mitc/category_determination'

RSpec.describe ::AcaEntities::Medicaid::Mitc::CategoryDetermination do
  let(:required_params) do
    { indicator_code: 'Y',
      ineligibility_code: 130 }
  end
  let(:optional_params) { { ineligibility_reason: 'Testing' } }
  let(:all_params) { required_params.merge(optional_params) }

  describe 'with valid arguments' do
    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a ::AcaEntities::Medicaid::Mitc::CategoryDetermination
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end
end
