# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Protocols::Transmittable::Contracts::ProcessStatusContract do
  subject { described_class.new }

  let(:params) do
    {
      initial_state_key: :initial,
      latest_state: :initial
    }
  end

  context 'Given valid required params' do
    it 'should initialize and be valid' do
      expect(subject.call(params)).to be_success
    end
  end

  context 'Given invalid required params' do
    it 'should initialize but not valid' do
      params[:initial_state_key] = ""
      expect(subject.call(params)).to be_failure
    end
  end
end
