# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::SubjectsContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:subject_gid_string) do
    'gid://enroll_app/Family/98765/FamilyMember/234567'
  end
  let(:eligibility_subject) { { subject_gid_string: {} } }
  let(:subjects) { { subjects: eligibility_subject } }

  context 'Given a subjects key' do
    it 'should validate' do
      expect(subject.call(subjects)).to be_truthy
    end
  end
end
