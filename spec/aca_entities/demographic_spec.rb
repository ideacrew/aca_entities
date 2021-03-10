# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/demographic'

RSpec.describe ::AcaEntities::Demographic, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:required_params) { { dob: Date.today, gender: 'Male' } }

    let(:optional_params) do
      { is_veteran_or_active_military: false,
        age_of_applicant: 30 }
    end
    let(:input_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:dob is missing in Hash input/)
    end
  end
end
