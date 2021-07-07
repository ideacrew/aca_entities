# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/chip_trafficking_victim_category_eligibility_basis'
require 'aca_entities/medicaid/atp/chip_eligibility'

RSpec.describe ::AcaEntities::Medicaid::Atp::ChipEligibility,  dbclean: :around_each do
  
  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do 
      {
        trafficking_victim_category_eligibility_basis: { status_indicator: true } 
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

