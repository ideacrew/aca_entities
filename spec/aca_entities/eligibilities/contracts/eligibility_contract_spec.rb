# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Contracts::EligibilityContract do
  include_context 'eligibilities_shared_context'
  subject { described_class.new }

  let(:elig_subject) do
    {
      title: 'OSSE Eligibility',
      klass: URI('gid://enroll_app/Family/98765/FamilyMember/234567'),
      key: 'FamilyMemberSubject',
      outstanding_verification_status: 'eligible',
      eligibility_states: {}
    }
  end

  let(:value) do
    {
      title: 'Osse Premium Credit',
      key: 'OsseBenefitSponsorGrant'
    }
  end

  let(:grant) do

    {
      title: 'Osse Eligibility',
      key: 'OsseBenefitSponsorGrant',
      value: value,
      start_on: five_days_from_today,
      end_on: Date.today.next_month
    }
  end

  let(:required_params) do
    {
      subject: elig_subject,
      effective_date: Date.today,
      grants: [grant],
      start_on: Date.today,
      end_on: five_days_from_today
    }
  end

  context 'Given a subjects key' do
    it 'should validate' do
      expect(subject.call(required_params)).to be_truthy
    end
  end
end
