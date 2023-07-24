# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Eligible::AddGrant do

  let(:state_histories) do
    [AcaEntities::Eligible::StateHistory.new(history_params)]
  end

  let(:history_params) do
    {
      effective_on: Date.today,
      is_eligible: true,
      from_state: :draft,
      to_state: :eligible,
      event: :move_to_eligible,
      transition_at: DateTime.now
    }
  end

  let(:evidence_params) do
    [
      {
        key: :shop_osse_evidence,
        title: 'childcare subsidy',
        is_satisfied: true,
        description: 'childcare subsidy evidence',
        state_histories: state_histories
      }
    ]
  end

  let(:grant_params) do
    [
      {
        key: :min_employee_relaxed_grant,
        title: 'minimum employee rule relaxed',
        description: 'relaxed minimum number of employees',
        value: AcaEntities::Eligible::Value.new(title: 'minimum employee rule relaxed', key: :min_employee_relaxed).to_h,
        state_histories: state_histories
      }
    ]
  end

  let(:eligibility_params) do
    {
      key: :shop_osse_eligibility,
      title: 'childcare subsidy',
      description: 'childcare subsidy eligibility',
      state_histories: state_histories,
      evidences: evidence_params,
      grants: grant_params
    }
  end

  let(:required_params) do
    {
      subject: 'AcaEntities::BenefitSponsors::BenefitSponsorships::BenefitSponsorship',
      eligibility: eligibility_params,
      grant: grant_params.first.merge(title: 'minimum employee rule relaxed 2')
    }
  end

  context 'Initializing with required params' do
    it 'should return grant and eligibility' do
      result = subject.call(required_params)

      expect(result).to be_success
      output = result.value!

      expect(output.first).to be_a AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibility::Grant
      expect(output.last).to be_a AcaEntities::BenefitSponsors::BenefitSponsorships::ShopOsseEligibility::Eligibility
    end

    it 'should return eligibility with newly added grant' do
      result = subject.call(required_params)

      expect(result).to be_success
      output = result.value!

      eligibility = output.last
      expect(eligibility.grants.count).to eq 2
      expect(eligibility.grants.map(&:title)).to include('minimum employee rule relaxed 2')
    end
  end
end
