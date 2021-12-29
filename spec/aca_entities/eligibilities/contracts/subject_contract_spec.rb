# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::SubjectContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  # let(:gid) { URI('gid://enroll_app/Family/98765/FamilyMember/234567') }
  let(:first_name) { 'Michael' }
  let(:last_name) { 'Brady' }
  let(:is_primary) { true }
  let(:eligibility_states) { {} }

  let(:required_params) do
    {
      # gid: gid,
      first_name: first_name,
      last_name: last_name,
      dob: Date.new(1985, 2, 1),
      hbx_id: '4121212',
      person_id: '2',
      is_ov_eligible: 'eligible',
      is_primary: is_primary,
      eligibility_states: eligibility_states
    }
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        # gid: ['is missing'],
        first_name: ['is missing'],
        last_name: ['is missing'],
        dob: ['is missing'],
        hbx_id: ['is missing'],
        is_ov_eligible: ['is missing'],
        person_id: ['is missing'],
        is_primary: ['is missing'],
        eligibility_states: ['is missing']
      }
    end

    it 'should fail validation' do
      result = described_class.new.call({})
      expect(result.failure?).to be_truthy
      expect(result.errors.to_h).to eq error_message
    end
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = subject.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end
end
