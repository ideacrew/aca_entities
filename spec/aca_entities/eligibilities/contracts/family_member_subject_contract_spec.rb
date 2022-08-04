# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Eligibilities::Contracts::FamilyMemberSubjectContract do
  subject { described_class.new }

  let(:optional_params) { {} }

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

  let(:all_params) { required_params.merge(optional_params) }

  context 'contract with no params' do
    let(:error_message) do
      {
        first_name: ['is missing'],
        last_name: ['is missing'],
        dob: ['is missing'],
        hbx_id: ['is missing'],
        person_id: ['is missing'],
        is_primary: ['is missing']
      }
    end

    it 'should fail validation' do
      result = described_class.new.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'contract with required params' do

    it 'should pass validation' do
      result = subject.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end
end
