# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/current_income'

RSpec.describe ::AcaEntities::VlpDocument, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { most_recent_hire_date: Date.today,
        termination_date: Date.today.next_year,
        pay_rate: 15,
        data_source_payment_frequency_code: 'Weekly' }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
