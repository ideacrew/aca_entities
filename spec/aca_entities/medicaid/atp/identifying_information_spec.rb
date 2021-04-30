# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/identifying_information'

RSpec.describe ::AcaEntities::Medicaid::Atp::IdentifyingInformation do

  describe 'with valid arguments' do
    let(:input_params) do
      { ssn: '123456789',
        hbx_id: '95',
        medicaid_id: 'medicaid_id',
        chip_id: 'chip_id',
        primary_insured: true,
        temporary_id: 'temporary_id' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
