# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Protocols::Transmittable::ProcessStatus do
  let(:params) do
    {
      initial_state_key: :initial,
      latest_state: :initial
    }
  end

  context 'Given valid required params' do
    it 'should initialize and be valid' do
      expect(described_class.new(params).to_h).to eq params
    end
  end
end
