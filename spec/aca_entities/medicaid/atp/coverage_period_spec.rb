# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/coverage_period'

RSpec.describe ::AcaEntities::Medicaid::Atp::CoveragePeriod, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      { start_date: Date.today,
        start_reason_text: 'Start Reason',
        end_date: Date.today.next_year,
        end_reason_text: 'End Reason' }
    end

    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end
end
