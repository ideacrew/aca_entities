# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/person_description_identifier'

RSpec.describe ::AcaEntities::Medicaid::Atp::PersonDescriptionIdentifier do

  describe 'with valid arguments' do
    let(:input_params) do
      { is_full_time_student: false }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
