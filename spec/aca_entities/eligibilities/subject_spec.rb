# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Subject do
  include_context 'eligibilities_shared_context'
  subject { described_class }

  let(:gid) { URI('gid://enroll_app/Family/98765/FamilyMember/234567') }
  let(:first_name) { 'Michael' }
  let(:last_name) { 'Brady' }
  let(:is_primary) { true }
  let(:eligibility_states) { {} }

  let(:required_params) do
    {
      gid: gid,
      first_name: first_name,
      last_name: last_name,
      is_primary: is_primary,
      dob: Date.new(1985, 2, 1),
      hbx_id: '4121212',
      person_id: '2',
      outstanding_verification_status: 'eligible',
      eligibility_states: eligibility_states
    }
  end

  let(:all_params) { required_params }

  context 'Initializing with required params' do
    it 'should pass initialize' do
      result = described_class.new(required_params)

      expect(result).to be_a described_class
    end
  end
end
