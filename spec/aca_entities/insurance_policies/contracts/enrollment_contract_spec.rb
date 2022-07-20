# frozen_string_literal: true

require 'spec_helper'
require 'support/shared_content/insurance_policies/contracts/shared_context'

RSpec.describe AcaEntities::InsurancePolicies::Contracts::EnrollmentContract do
  include_context('insurance_policies_context')
  subject { described_class.new }

  let(:moment) { DateTime.now }
  let(:id) { '12345' }

  let(:subscriber) { george_jetson[:enrolled_member] }
  let(:dependents) { [jane_jetson[:enrolled_member]] }
  let(:enrollment_elections) { [initial_enrollment_election] }
  let(:subscriber_service_area_id) { 's101' }
  let(:subscriber_rating_area_id) { 'r101' }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) do
    {
      subscriber: subscriber,
      enrollment_elections: enrollment_elections,
      subscriber_service_area_id: subscriber_service_area_id,
      subscriber_rating_area_id: subscriber_rating_area_id
    }
  end
  let(:optional_params) { { id: id, dependents: dependents, timestamps: timestamps } }

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
        subscriber: ['is missing'],
        enrollment_elections: ['is missing'],
        subscriber_service_area_id: ['is missing'],
        subscriber_rating_area_id: ['is missing']
      }
    end
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
