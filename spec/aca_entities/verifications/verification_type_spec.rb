# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Verifications::VerificationType, dbclean: :after_each do

  let!(:person_reference) do
    {
      hbx_id: '1234',
      first_name: 'first name',
      middle_name: 'middle name',
      last_name: 'last name',
      dob: Date.today,
      gender: 'male',
      ssn: nil
    }
  end

  let!(:input_params) do
    {
      type_name: "DC Residency",
      validation_status: "attested",
      applied_roles: ["consumer_role"],
      update_reason: nil,
      rejected: false,
      external_service: nil,
      due_date: nil,
      due_date_type: nil,
      updated_by: person_reference,
      inactive: nil,
      vlp_documents: []
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
      expect { described_class.new(input_params.reject { |k, _v| k == :type_name }) }.to raise_error(Dry::Struct::Error, /:type_name is missing/)
    end
  end
end


