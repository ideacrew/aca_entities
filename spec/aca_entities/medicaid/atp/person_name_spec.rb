# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/person_name'

RSpec.describe ::AcaEntities::Medicaid::Atp::PersonName, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { given: 'first',
        middle: 'middle',
        sur: 'last',
        full: 'prefix first middle last suffix'
      }
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
      expect { subject }.to raise_error(Dry::Struct::Error, /:given is missing in Hash input/)
    end
  end
end
