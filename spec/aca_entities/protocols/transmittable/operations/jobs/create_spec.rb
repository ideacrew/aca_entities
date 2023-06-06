# frozen_string_literal: true

RSpec.describe AcaEntities::Protocols::Transmittable::Operations::Jobs::Create do
  let(:title) { 'A dummy job' }
  let(:description) { 'A dummy job for testing' }
  let(:status) { :initial }
  let(:process_states) { [] }
  let(:timestamps) { { created_at: DateTime.now, modified_at: DateTime.now } }

  let(:params) do
    {
      title: title,
      description: description,
      status: status,
      process_states: process_states,
      timestamps: timestamps
    }
  end

  context 'Calling the operation with valid params' do
    it 'should create a job' do
      result = subject.call(params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq job
    end
  end

end
