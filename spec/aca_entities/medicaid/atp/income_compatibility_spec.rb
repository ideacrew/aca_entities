# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/activity_identification'
require 'aca_entities/medicaid/atp/activity_date'
require 'aca_entities/medicaid/atp/income_compatibility_determination'
require 'aca_entities/medicaid/atp/income_compatibility'

RSpec.describe ::AcaEntities::Medicaid::Atp::IncomeCompatibility,  dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      {
        verification_indicator: true,
        inconsistency_reason_text: "123",
        compatibility_determination: compatibility_determination,
        verification_method: "1"
      }
    end

    let(:compatibility_determination) do
      {
        activity_identification: { identification_id: "MET00000000001887090" },
        activity_date: { date_time: DateTime.now }
      }
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

