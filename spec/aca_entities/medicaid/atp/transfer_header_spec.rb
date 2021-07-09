# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/transfer_header'

RSpec.describe ::AcaEntities::Medicaid::Atp::TransferHeader do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        transfer_activity: transfer_activity
      }
    end

    let(:transfer_activity) do
      {
        transfer_id: { identification_id: '2163565' },
        transfer_date: { date_time: DateTime.now },
        number_of_referrals: 1,
        recipient_code: 'MedicaidCHIP',
        state_code: 'ME'
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
