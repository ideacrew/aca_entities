# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Currency do

  let!(:input_params) do
    {
      cents: 0.0,
      currency_iso: "USD"
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
