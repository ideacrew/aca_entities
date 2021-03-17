# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mitc/types'
require 'aca_entities/medicaid/mitc/contracts/relationship_contract'
require 'aca_entities/medicaid/mitc/contracts/deprived_child_contract'
require 'aca_entities/medicaid/mitc/contracts/qualified_child_contract'
require 'aca_entities/medicaid/mitc/contracts/person_reference_contract'
require 'aca_entities/medicaid/mitc/contracts/category_determination_contract'
require 'aca_entities/medicaid/mitc/contracts/household_contract'
require 'aca_entities/medicaid/mitc/contracts/applicant_contract'
require 'aca_entities/medicaid/mitc/contracts/eligibility_response_contract'

RSpec.describe ::AcaEntities::Medicaid::Mitc::Contracts::EligibilityResponseContract do
  let(:applicant_params) do
    { person_id: 100,
      medicaid_household: { household_id: 1000, people: [{ person_id: 100 }] },
      is_medicaid_eligible: 'N',
      is_chip_eligible: 'N',
      medicaid_ineligibility_reasons: ['test'],
      is_eligible_for_non_magi_reasons: 'N',
      chip_ineligibility_reasons: ['test'],
      medicaid_category: 'Medicaid Category',
      medicaid_category_threshold: 100,
      physical_households: [{ household_id: 1000, people: [{ person_id: 100 }] }],
      chip_category: 'Chip Category',
      chip_category_threshold: 50,
      category_determination: { indicator_code: 'Y',
                                ineligibility_code: 123,
                                ineligibility_reason: 'Nothing' },
      qualified_children: [{ person_id: 101,
                             determination: { indicator_code: 'Y',
                                              ineligibility_code: 123,
                                              ineligibility_reason: 'Nothing' },
                             deprived_child: { qualify_as_deprived_child: 'N' },
                             relationship: { other_id: 100,
                                             attest_primary_responsibility: 'Y',
                                             relationship_code: '01' } }] }
  end

  let(:required_params) do
    { determination_date: Date.new, applicants: [applicant_params] }
  end

  context 'valid params' do
    it { expect(subject.call(required_params).success?).to be_truthy }
    it { expect(subject.call(required_params).to_h).to eq required_params }
  end

  context 'invalid params' do
    context 'with no parameters' do
      before :each do
        @result = subject.call({})
      end

      it 'should return a failure' do
        expect(@result.success?).to be_falsey
      end

      it 'should list error for every required parameter' do
        expect(@result.errors.to_h.keys).to match_array required_params.keys
      end
    end
  end
end
