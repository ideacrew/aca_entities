# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::EventLogs::EventLogContract do

  let(:input_params) do
    {
      subject_gid: 'BenefitSponsorship',
      correlation_id: '13423234-23232323',
      event_category: event_category,
      session_id: '1234567',
      account_id: '96',
      host_id: 'enroll',
      trigger: 'determine_eligibility',
      response: 'success',
      log_level: :debug,
      severity: :debug,
      event_time: DateTime.now,
      tags: []
    }
  end

  describe 'with valid arguments' do

    let(:event_category) { :osse_eligibility }

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
