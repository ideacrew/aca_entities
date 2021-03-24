# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/person_reference'

RSpec.describe ::AcaEntities::MagiMedicaid::PersonReference, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { person_id: 100 }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(person_id: 'Test') }.to raise_error(Dry::Struct::Error, /invalid type for :person_id violates constraints/)
    end
  end
end
