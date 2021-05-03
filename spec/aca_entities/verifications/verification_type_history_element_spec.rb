# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Verifications::VerificationTypeHistoryElement, dbclean: :after_each do

  let(:input_params) do
    { verification_type: "Social Security Number",
      action: "SSA Hub Request",
      modifier: "Enroll App",
      update_reason: "Hub request" }
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
                              k == :verification_type
                            end)
      end.to raise_error(Dry::Struct::Error, /:verification_type is missing/)
    end
  end
end




