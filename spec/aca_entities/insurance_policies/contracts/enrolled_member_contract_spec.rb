# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::InsurancePolicies::Contracts::EnrolledMemberContract do
  subject { described_class.new }

  let(:id) { '12345' }

  # Member
  let(:member_id) { '987654' }
  let(:person_name) { { first_name: 'George', last_name: 'Jetson' } }
  let(:dob) { Date.new(1988, 3, 15) }
  let(:gender) { 'male' }
  let(:timestamps) { { created_at: moment, modified_at: moment } }
  let(:member) { { member_id: member_id, person_name: person_name, gender: gender, dob: dob } }

  # PremiumSchedule
  let(:premium_amount) { 345.66 }
  let(:insured_start_on) { Date.new(moment.year, 1, 1) }
  let(:insured_end_on) { Date.new(moment.year, 3, 1) }
  let(:valid_start_on) { Date.new(moment.year, 1, 1) }
  let(:valid_end_on) { Date.new(moment.year, 12, 31) }

  let(:premium_schedule) do
    {
      premium_amount: premium_amount,
      insured_start_on: insured_start_on,
      insured_end_on: insured_end_on,
      valid_start_on: valid_start_on,
      valid_end_on: valid_end_on
    }
  end

  # EnrolledMemberPremium
  let(:insurance_rate) { 575.23 }
  let(:enrolled_member_premium) { { premium_schedule: premium_schedule, insurance_rate: insurance_rate } }

  # PrimaryCareProvider
  let(:primary_care_provider) { { name: { first_name: 'Florence', last_name: 'Nightengale' } } }

  let(:is_tobacco_user) { false }
  let(:moment) { DateTime.now }
  let(:timestamps) { { created_at: moment, modified_at: moment } }

  let(:required_params) { { member: member, enrolled_member_premium: enrolled_member_premium } }
  let(:optional_params) do
    { id: id, is_tobacco_user: is_tobacco_user, primary_care_provider: primary_care_provider, timestamps: timestamps }
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
    let(:error_message) { { member: ['is missing'], enrolled_member_premium: ['is missing'] } }
    it 'should pass validation' do
      result = subject.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end
end
