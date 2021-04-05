# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/native_american_information'

RSpec.describe ::AcaEntities::Medicaid::Atp::NativeAmericanInformation, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:required_params) { { is_native_american_or_alaska_native: true } }

    let(:optional_params) do
      { indian_tribe_state_code: 'Maine',
        federally_recognized_tribe: true,
        tribe_name: 'Tribe',
        itu_eligible: false,
        received_ihs: false }
    end
    let(:input_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      msg = /:is_native_american_or_alaska_native is missing in Hash input/
      expect { subject }.to raise_error(Dry::Struct::Error, msg)
    end
  end
end
