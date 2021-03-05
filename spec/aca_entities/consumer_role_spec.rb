# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/consumer_role'

RSpec.describe ::AcaEntities::ConsumerRole, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { is_active: true,
        is_applying_coverage: true,
        is_applicant: true,
        is_state_resident: true,
        lawful_presence_determination: 'lawful_presence',
        citizen_status: 'us_citizen' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
