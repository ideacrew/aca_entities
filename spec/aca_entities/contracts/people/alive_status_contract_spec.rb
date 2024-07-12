# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::People::AliveStatusContract do
  let(:input_params) { { is_deceased: false, date_of_death: nil } }

  context '#call' do
    it 'returns success' do
      result = subject.call(input_params)

      expect(result.success?).to be_truthy
      expect(result.to_h).to eq input_params
    end

    it 'returns results without any errors' do
      expect(subject.call(input_params).errors.empty?).to be_truthy
    end
  end
end
