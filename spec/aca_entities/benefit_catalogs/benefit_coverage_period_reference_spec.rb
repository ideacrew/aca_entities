# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::BenefitCatalogs::BenefitCoveragePeriodReference, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      {
        title: 'test title',
        market_place: 'individual',
        start_on: Date.today,
        end_on: Date.today,
        open_enrollment_start_on: Date.today,
        open_enrollment_end_on: Date.today
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
    let(:invalid_params) do
      {
        title: 'test title',
        market_place: 'test',
        start_on: Date.today,
        end_on: Date.today,
        open_enrollment_start_on: Date.today,
        open_enrollment_end_on: Date.today
      }
    end
    it 'should raise error' do
      expect { described_class.new(invalid_params) }.to raise_error(Dry::Struct::Error, /:market_place violates constraints/)
    end
  end
end
