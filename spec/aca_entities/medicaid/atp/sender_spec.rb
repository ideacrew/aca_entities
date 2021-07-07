# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/sender'

RSpec.describe ::AcaEntities::Medicaid::Atp::Sender do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        category_code: 'Exchange',
        state_code: nil,
        county_name: nil
      }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
