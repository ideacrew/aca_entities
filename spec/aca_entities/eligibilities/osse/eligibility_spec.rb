# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/eligibilities/eligibilities_shared_context'

RSpec.describe AcaEntities::Eligibilities::Osse::Eligibility do
  include_context 'eligibilities_shared_context'
  subject { described_class }

  let(:subject) do
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
      subject: subject,
      effective_date: Date.today,
      grants: [grant],
      start_on: Date.today,
      end_on: five_days_from_today
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
