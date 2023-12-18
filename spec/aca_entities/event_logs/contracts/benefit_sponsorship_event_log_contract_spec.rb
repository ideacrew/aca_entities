# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::EventLogs::BenefitSponsorshipEventLogContract do

  let(:input_params) do
    {
      subject_gid: 'BenefitSponsorship',
      correlation_id: '13423234-23232323',
      event_category: event_category,
      message_id: SecureRandom.uuid,
      session_id: '1234567',
      account_id: '96',
      host_id: 'enroll',
      trigger: 'determine_eligibility',
      session_detail: session_detail,
      event_time: DateTime.now,
      tags: []
    }
  end

  let(:event_category) { :osse_eligibility }
  let(:session_detail) do
    {
      session_id: SecureRandom.uuid,
      login_session_id: SecureRandom.uuid,
      portal: 'http://dchealthlink.com'
    }
  end

  describe 'with valid arguments' do

    it 'should return success' do
      expect(described_class.new.call(input_params).success?).to be_truthy
    end
  end

  describe 'with invalid arguments' do
    let(:event_category) { nil }

    it 'should return failure' do
      result = described_class.new.call(input_params)

      expect(result.success?).to be_falsey
      expect(result.errors.to_h).to eq({ :event_category => ["must be filled"] })
    end
  end
end
