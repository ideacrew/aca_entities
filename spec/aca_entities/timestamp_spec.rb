# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::TimeStamp do

  let(:input_params) do
    {
      submitted_at: DateTime.now,
      created_at: DateTime.now,
      modified_at: DateTime.now
    }
  end

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { subject }.not_to raise_error
    end
  end
end
