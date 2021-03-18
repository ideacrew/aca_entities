# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/foster_care'

RSpec.describe ::AcaEntities::Medicaid::Atp::FosterCare, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      { attested_foster_care: true,
        age_left_foster_care: 10,
        foster_care_us_state_code: 'DC',
        had_medicaid_during_foster_care: false }
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
