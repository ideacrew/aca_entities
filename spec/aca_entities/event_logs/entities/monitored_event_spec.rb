# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::EventLogs::MonitoredEvent do

  let(:input_params) do
    {
      account_id: '96',
      subject_hbx_id: '623340',
      event_category: event_category,
      event_time: DateTime.now,
      login_session_id: SecureRandom.uuid
    }
  end

  let(:event_category) { :osse_eligibility }

  describe 'with valid arguments' do
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
