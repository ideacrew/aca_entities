# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Households::TaxHouseholdMemberReference, dbclean: :after_each do

  let(:input_params) do
    {
      is_subscriber: true,
      reason: nil
    }
  end

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect do
        described_class.new(input_params.reject do |k, _v|
                              k == :is_subscriber
                            end)
      end.to raise_error(Dry::Struct::Error, /:is_subscriber is missing/)
    end
  end
end
