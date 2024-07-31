# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Cms::Pbp::SbmiEnrollee do
  subject { described_class.new }

  let(:required_params) do
    {
      exchange_assigned_memberId: "99921",
      subscriber_indicator: "Y",
      person_last_name: "SMITH",
      birth_date: Date.today.prev_year,
      postal_code: "12345",
      member_start_date: Date.today,
      member_end_date: Date.today,
      gender_code: "M"
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
          k == :birth_date
        end)
      end.to raise_error(Dry::Struct::Error, /:birth_date is missing/)
    end
  end
end
