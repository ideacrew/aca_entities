# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/attestation'

RSpec.describe ::AcaEntities::Medicaid::Atp::Attestation do

  describe 'with valid arguments' do
    let(:input_params) do
      { is_incarcerated: false,
        attested_not_incarcerated_indicator: false,
        attested_if_information_changes_indicator: true,
        attested_non_perjury_indicator: true,
        tax_return_access_indicator: true,
        tax_return_access: true }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
