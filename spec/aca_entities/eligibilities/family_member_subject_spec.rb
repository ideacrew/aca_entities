# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Eligibilities::FamilyMemberSubject do
  subject { described_class }

  let(:required_params) do
    {
      first_name: 'first name',
      last_name: 'last name',
      encrypted_ssn: "123456789",
      dob: Date.today,
      hbx_id: '1001',
      person_id: "5",
      is_primary: true
    }
  end

  context 'Initializing with required params' do
    it 'should initialize the entity' do
      result = described_class.new(required_params)

      expect(result).to be_a described_class
    end
  end

  context 'with invalid arguments' do
    it 'should raise error' do
      expect do
        described_class.new(required_params.reject do |k, _v|
                              k == :dob
                            end)
      end.to raise_error(Dry::Struct::Error, /:dob is missing/)
    end
  end
end
