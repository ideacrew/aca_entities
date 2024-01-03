# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::EventLogs::EventLogContract do

  let(:input_params) do
    {
      subject_gid: 'BenefitSponsorship',
      correlation_id: '13423234-23232323',
      event_category: event_category,
      message_id: SecureRandom.uuid,
      account_id: '96',
      host_id: 'enroll',
      event_name: 'events.determine_eligibility',
      event_time: DateTime.now,
      session_detail: session_detail,
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

  describe 'when session detail missing' do
    let(:session_detail) { {} }

    it 'should fail ' do
      result = described_class.new.call(input_params)

      expect(result.success?).to be_falsey
      expect(result.errors.to_h).to eq({ :session_detail => { :login_session_id => ["is missing"], :portal => ["is missing"],
                                                              :session_id => ["is missing"] } })
    end
  end

  describe 'extending event log contract schema' do

    let(:new_contract) do
      Class.new(Dry::Validation::Contract) do
        params(::AcaEntities::EventLogs::EventLogContract.schema) do
          required(:custom_field).filled(:string)
        end
      end
    end

    it 'should fail without custom field' do
      result = new_contract.new.call(input_params)

      expect(result.success?).to be_falsey
      expect(result.errors.to_h).to eq({ :custom_field => ["is missing"] })
    end

    it 'should pass with custom field' do
      input_params[:custom_field] = 'custom_field'
      result = new_contract.new.call(input_params)

      expect(result.success?).to be_truthy
    end
  end
end
