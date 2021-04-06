# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Student, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { is_student: true,
        student_kind: 'graduated',
        student_school_kind: 'graduate_school',
        student_status_end_on: Date.today.prev_year }
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
      expect { described_class.new(is_student: 'Test') }.to raise_error(Dry::Struct::Error, /has invalid type for :is_student/)
    end
  end
end
