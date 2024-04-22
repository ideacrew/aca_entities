# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::EventLogs::MonitoredEventContract do

  let(:input_params) do
    {
      account_hbx_id: '963434',
      account_username: 'sample_username',
      subject_hbx_id: '623340',
      event_category: event_category,
      event_time: DateTime.now,
      login_session_id: SecureRandom.uuid
    }
  end

  let(:event_category) { :osse_eligibility }

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

