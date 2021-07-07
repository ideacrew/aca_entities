# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/tribal_augmentation'

RSpec.describe ::AcaEntities::Medicaid::Atp::TribalAugmentation, dbclean: :around_each do
  
  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      { recognized_tribe_indicator: true,
        american_indian_or_alaska_native_indicator: true,
        person_tribe_name: "Tribe Name",
        location_state_us_postal_service_code: "ME"
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

