# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/referral_activity_sender_reference'
require 'aca_entities/medicaid/atp/referral_activity_receiver_reference'
require 'aca_entities/medicaid/atp/activity_identification'
require 'aca_entities/medicaid/atp/activity_date'
require 'aca_entities/medicaid/atp/referral_activity_status'
require 'aca_entities/medicaid/atp/referral_activity'

RSpec.describe ::AcaEntities::Medicaid::Atp::ReferralActivity,  dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) do
      { activity_id: { identification_id: "01234" },
        activity_date: { date_time: DateTime.now },
        sender_reference: { ref: "Sender" },
        receiver_reference: { ref: "Receiver" },
        status: { status_code: "Initiated", overall_verification_status_code: "Y" } }
    end

    let(:optional_params) do
      {
        # activity_identification: {},
        reason_code: "WaitingPeriodException"
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