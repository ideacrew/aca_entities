# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/activity_identification'
require 'aca_entities/medicaid/atp/activity_date'
require 'aca_entities/medicaid/atp/transfer_activity'

RSpec.describe ::AcaEntities::Medicaid::Atp::TransferActivity,  dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) do
      {
        transfer_id: { identification_id: '2163565' },
        number_of_referrals: 1
      }
    end

    let(:optional_params) { { transfer_date: { date_time: DateTime.now }, recipient_code: 'MedicaidCHIP', state_code: 'ME' } }

    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end
end