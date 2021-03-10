# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/identifying_information'

RSpec.describe ::AcaEntities::IdentifyingInformation do

  describe 'with valid arguments' do
    let(:input_params) do
      { ssn: '123456789',
        hbx_id: '100' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
