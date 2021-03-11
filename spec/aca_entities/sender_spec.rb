# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/sender'

RSpec.describe ::AcaEntities::Sender do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        sender_code: nil,
        sender_medicaid_chip_state: nil,
        sender_medicaid_chip_county: nil
      }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
