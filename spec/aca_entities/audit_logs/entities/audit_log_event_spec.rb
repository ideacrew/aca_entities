# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::AuditLogs::AuditLogEvent do

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
