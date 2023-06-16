# frozen_string_literal: true

RSpec.describe AcaEntities::Protocols::Transmittable::Operations::Jobs::Create do
  let(:title) { 'A dummy job' }
  let(:description) { 'A dummy job for testing' }
  let(:key) { 'A dummy job name' }
  let(:started_at) { DateTime.now }
  let(:time_to_live) { 1 }
  let(:publish_on) { Date.today }
  let(:status) { :initial }
  let(:process_status) { { initial_state_key: :initial } }
  let(:errors) { [] }
  let(:timestamps) { { created_at: DateTime.now, modified_at: DateTime.now } }

  let(:params) do
    {
      job_id: 'test_123',
      key: key,
      time_to_live: time_to_live,
      publish_on: publish_on,
      errors: errors,
      title: title,
      description: description,
      status: status,
      process_status: process_status,
      started_at: started_at,
      timestamps: timestamps
    }
  end

  context 'Calling the operation with valid params' do
    it 'should create a job' do
      result = subject.call(params)
      expect(result.success?).to be_truthy
      expect(result.success.class).to eq AcaEntities::Protocols::Transmittable::Job
    end
  end

end
