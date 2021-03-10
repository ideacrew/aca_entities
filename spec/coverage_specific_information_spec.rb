# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/coverage_specific_information'

RSpec.describe ::AcaEntities::CoverageSpecificInformation, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      { coverage_type_code: 'EmergencyMedicaid',
        aptc: 20.00,
        net_premium: 80.00,
        qhp_issuer_id: nil,
        qhp_id: nil,
        metal_level_code: 'Platinum',
        issuer_name: 'KP',
        plan_name: 'Test Plan' }
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
