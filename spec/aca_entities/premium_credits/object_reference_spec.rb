# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::PremiumCredits::ObjectReference, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { identifier: '100',
        label: "FinancialAssistance::Application" }
    end

    before do
      params = AcaEntities::PremiumCredits::Contracts::ObjectReferenceContract.new.call(input_params).to_h
      @result = described_class.new(params)
    end

    it 'should return object_reference entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of object_reference' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end
  end
end
