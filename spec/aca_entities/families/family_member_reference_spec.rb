# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Families::FamilyMemberReference, dbclean: :after_each do

  let(:input_params) do
    {
      family_member_hbx_id: '1001',
      first_name: 'first name',
      last_name: 'last name',
      person_hbx_id: '1001',
      is_primary_family_member: true,
      relation_with_primary: 'self'
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
                              k == :family_member_hbx_id
                            end)
      end.to raise_error(Dry::Struct::Error, /:family_member_hbx_id is missing/)
    end
  end
end
