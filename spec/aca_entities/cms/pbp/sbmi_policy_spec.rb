# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Cms::Pbp::SbmiPolicy, dbclean: :after_each do
  subject { described_class.new }

  let(:required_params) do
    {
      record_control_number: 1,
      qhp_id: '1',
      rating_area: '1',
      exchange_policy_id: '1',
      exchange_subscriber_id: '1',
      coverage_start: Date.today,
      coverage_end: Date.today,
      effectuation_status: 'Y',
      insurance_line_code: 'insurance_line_code'
    }
  end

  describe 'with valid arguments' do
    it 'should initialize' do
      expect(described_class.new(required_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(required_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect do
        described_class.new(required_params.reject do |k, _v|
          k == :record_control_number
        end)
      end.to raise_error(Dry::Struct::Error, /:record_control_number is missing/)
    end
  end
end