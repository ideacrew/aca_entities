# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::SubjectsContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:subject_1_gid) { URI('gid://enroll_app/Family/98765/FamilyMember/234567') }
  let(:subject_2_gid) { URI('gid://enroll_app/Family/98765/FamilyMember/234568') }

  let(:required_params) { { subjects: { subject_1_gid => { determinations: {} }, subject_2_gid => { determinations: {} } } } }

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = subject.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end
end
