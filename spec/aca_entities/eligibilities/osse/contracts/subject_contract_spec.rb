# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Osse::Contracts::SubjectContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:title) { 'OSSE Eligibility' }
  let(:key) { URI('gid://enroll_app/Family/98765/FamilyMember/234567') }
  let(:first_name) { 'Michael' }
  let(:last_name) { 'Brady' }
  let(:is_primary) { true }
  let(:eligibility_states) { {} }

  let(:required_params) do
    {
      title: title,
      klass: 'SomeClass',
      key: key
    }
  end

  context 'Calling the contract with no params' do
    let(:error_message) do
      {
        key: ['is missing'],
        klass: ['is missing'],
        title: ['is missing']
      }
    end

    it 'should fail validation' do
      result = described_class.new.call({ subject_type: 'FamilyMemberSubject', subject: {} })
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
