# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/authorized_representative'

RSpec.describe ::AcaEntities::AuthorizedRepresentative do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        first_name: nil,
        middle_name: nil,
        last_name: 'last_name',
        suffix: nil,
        legal_name: nil,
        fein: nil,
        designation_date: Date.today.to_date
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
