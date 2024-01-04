# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::EventLogs::EventLog do

  let(:event_class) do
    Class.new(Dry::Struct) do
      include ::AcaEntities::EventLogs::EventLog
    end
  end

  let(:input_params) do
    {
      account_id: '96',
      subject_gid: 'gid://enroll/BenefitSponsors::Organizations::GeneralOrganization/5d8518611bdce254e0717301',
      resource_gid: 'gid://enroll/BenefitSponsors::BenefitSponsorships::ShopOsseEligibilities::ShopOsseEligibility/651717acf1ff6d456b041c7c',
      correlation_id: '13423234-23232323',
      message_id: SecureRandom.uuid,
      host_id: 'enroll',
      event_category: event_category,
      event_time: DateTime.now,
      session_detail: session_detail,
      event_name: 'events.determine_eligibility',
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

  let(:event_category) { :osse_eligibility }

  describe 'with valid arguments' do
    it 'should initialize' do
      expect(event_class.new(input_params)).to be_a event_class
    end

    it 'should not raise error' do
      expect { event_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'when session detail missing' do
    let(:session_detail) { {} }

    it 'should fail ' do
      expect { event_class.new(input_params) }.to raise_error(Dry::Struct::Error, /:session_id is missing in Hash input/)
    end
  end

  describe 'with invalid arguments' do

    let(:event_category) { nil }

    it 'should raise error' do
      input_params.delete(:event_category)
      expect { event_class.new(input_params) }.to raise_error(Dry::Struct::Error, /:event_category is missing in Hash input/)
    end
  end
end
