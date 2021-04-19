# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Households::CoverageHouseholdMember, dbclean: :after_each do

  let(:family_member_reference) do
    {
      family_member_hbx_id: '1001',
      first_name: 'first name',
      last_name: 'last name',
      person_hbx_id: '1001',
      is_primary_family_member: true
    }
  end

  let!(:input_params) do
    {
      family_member_reference: family_member_reference,
      is_subscriber: true
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
