# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::BenefitCatalogs::BenefitPackageReference do

  describe 'with valid arguments' do

    let(:input_params) do
      {
        title: 'test title',
        elected_premium_credit_strategy: 'unassisted'
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
        elected_premium_credit_strategy: 'unassisted'
      }
    end

    it 'should raise error' do
      expect { described_class.new(invalid_params) }.to raise_error(Dry::Struct::Error, /:title is missing/)
    end
  end
end
