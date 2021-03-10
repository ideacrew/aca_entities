# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/verification_header'

RSpec.describe ::AcaEntities::VerificationHeader do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        verification_date: Date.today,
        verified_by: 'Exchange',
        medicaid_chip_state: nil,
        medicaid_chip_county: nil,
        verification_type: 'SSN',
        verification_source: 'SSA',
        verification_status: 'FFEVerificationCode',
        verification_code: nil,
        response_code: nil
      }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
