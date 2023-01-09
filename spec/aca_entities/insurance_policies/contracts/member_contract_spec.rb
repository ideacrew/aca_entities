# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe AcaEntities::InsurancePolicies::Contracts::MemberContract do
  include_context('insurance_policies_context')
  subject { described_class.new }

  let(:id) { '12345' }
  let(:member_id) { '987654' }
  let(:insurer_assigned_id) { '555555' }
  let(:person_name) { { first_name: 'George', last_name: 'Jetson' } }
  let(:encrypted_ssn) { '777665432' }
  let(:dob) { Date.new(1988, 3, 15) }
  let(:gender) { 'male' }
  let(:relationship_code) { '1:18' }

  let(:emails) { [{ kind: 'home', address: 'george.jetson@example.com' }] }
  let(:phones) { [{ kind: 'mobile', primary: true, area_code: '208', number: '5551212', start_on: moment }] }
  let(:addresses) do
    [
      {
        kind: 'home',
        address_1: '1406 Albright St',
        city: 'Boise',
        county_name: 'Ada',
        state_abbreviation: 'ID',
        zip_code: '83705',
        start_on: moment
      }
    ]
  end

  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    { hbx_id: member_id, member_id: member_id, person_name: person_name, gender: gender,
      dob: dob }
  end
  let(:optional_params) do
    {
      id: id,
      insurer_assigned_id: insurer_assigned_id,
      encrypted_ssn: encrypted_ssn,
      gender: gender,
      emails: emails,
      phones: phones,
      addresses: addresses,
      timestamps: timestamps
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling contract with Valid params' do
    context 'Calling the contract with required params' do
      it 'should pass validation' do
        result = subject.call(required_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq required_params
      end
    end

    context 'Calling the contract with all params' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        hbx_id: ['is missing'],
        # relationship: ['is missing'],
        person_name: ['is missing']
      }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
