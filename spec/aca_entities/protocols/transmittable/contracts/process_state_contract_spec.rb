# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Protocols::Transmittable::Contracts::ProcessStateContract do
  subject { described_class.new }

  let(:params) do
    { event: 'event',
      message: 'message',
      started_at: DateTime.now,
      state_key: :initial }
  end

  context 'Given valid required params' do
    it 'should initialize and be valid' do
      expect(subject.call(params)).to be_success
    end
  end

  context 'Given invalid required params' do
    it 'should initialize not valid' do
      expect(subject.call(params.except(:event))).to be_failure
    end

    it 'should initialize not valid' do
      expect(subject.call(params.except(:message))).to be_failure
    end

    it 'should initialize not valid' do
      params[:started_at] = ''
      expect(subject.call(params)).to be_failure
    end

    it 'should initialize not valid' do
      params[:state_key] = ''
      expect(subject.call(params)).to be_failure
    end
  end
end
