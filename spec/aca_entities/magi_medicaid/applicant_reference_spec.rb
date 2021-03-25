# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/applicant_reference'

RSpec.describe ::AcaEntities::MagiMedicaid::ApplicantReference, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { first_name: 'First Test',
        last_name: 'Last Test',
        dob: Date.today.prev_year,
        person_hbx_id: '1000' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    context 'no params' do
      it 'should raise error' do
        expect { subject }.to raise_error(Dry::Struct::Error, /:first_name is missing/)
      end
    end

    context 'bad input values' do
      it 'should raise error' do
        expect { described_class.new(first_name: 100) }.to raise_error(Dry::Struct::Error, /has invalid type for :first_name/)
      end
    end
  end
end
