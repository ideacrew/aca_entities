# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::EventLogs::BenefitSponsorshipEventLog do

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

  let(:session_detail) do
    {
      session_id: SecureRandom.uuid,
      login_session_id: SecureRandom.uuid,
      portal: 'http://dchealthlink.com'
    }
  end

  describe 'with valid arguments' do

    let(:event_category) { :osse_eligibility }

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do

    let(:event_category) { nil }

    it 'should raise error' do
      input_params.delete(:event_category)
      expect { described_class.new(input_params) }.to raise_error(Dry::Struct::Error, /:event_category is missing in Hash input/)
    end
  end
end
