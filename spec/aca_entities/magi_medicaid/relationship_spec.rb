# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Relationship, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:applicant) do
      { first_name: 'First Test',
        last_name: 'Last Test',
        dob: Date.today.prev_year,
        person_hbx_id: '1000' }
    end

    let(:relative) do
      { first_name: 'Second Test',
        last_name: 'Last Test',
        dob: Date.today.prev_year,
        person_hbx_id: '1001' }
    end

    let(:input_params) do
      { kind: 'spouse',
        applicant: applicant,
        relative: relative }
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
      expect { subject }.to raise_error(Dry::Struct::Error, /:first_name is missing in Hash input/)
    end
  end
end
