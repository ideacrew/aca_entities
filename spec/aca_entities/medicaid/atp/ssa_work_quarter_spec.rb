# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/ssa_work_quarter'

RSpec.describe ::AcaEntities::Medicaid::Atp::SsaWorkQuarter do

  describe 'with valid arguments' do
    let(:input_params) do
      { work_year_date: Date.today,
        quarters_earned: 3 }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
