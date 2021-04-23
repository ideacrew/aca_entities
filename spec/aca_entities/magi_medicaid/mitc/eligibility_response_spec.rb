# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::EligibilityResponse do
  describe 'with valid arguments' do
    let(:category_determination) do
      { category: 'Child Category',
        indicator_code: 'N',
        ineligibility_code: 115,
        ineligibility_reason: 'Applicant is 19 years of age or older and the state does not cover young adults under age 20 or 21' }
    end

    let(:medicaid_household) do
      { people: [{ person_id: 100 }],
        magi_income: 25_608,
        size: 1 }
    end

    let(:qualified_child) do
      { person_id: 101,
        determination: { dependent_age: { is_person_of_dependent_age: 'N' } },
        deprived_child: { qualify_as_deprived_child: 'N' },
        parent_caretaker_relationship: { containing_person_is_qualified_for_parent_caretaker_status: 'N' } }
    end

    let(:other_output) do
      { qualified_children_list: [qualified_child] }
    end

    let(:applicant_params) do
      { person_id: 100,
        medicaid_household: medicaid_household,
        is_medicaid_eligible: 'N',
        is_chip_eligible: 'N',
        medicaid_ineligibility_reasons: ['test'],
        is_eligible_for_non_magi_reasons: 'N',
        chip_ineligibility_reasons: ['test'],
        medicaid_category: 'Medicaid Category',
        medicaid_category_threshold: 100,
        chip_category: 'Chip Category',
        chip_category_threshold: 50,
        determinations: [category_determination],
        other_output: other_output }
    end

    let(:eligibility_response) do
      { determination_date: Date.today.to_s, applicants: [applicant_params] }
    end

    before do
      contract_params = ::AcaEntities::MagiMedicaid::Mitc::Contracts::EligibilityResponseContract.new.call(eligibility_response).to_h
      @result = described_class.new(contract_params)
    end

    it 'should return EligibilityResponse entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of EligibilityResponse' do
      expect(@result.to_h.keys).to eq(eligibility_response.keys)
    end

    it 'should match all the input keys of applicant' do
      result_appli_keys = @result.to_h[:applicants].first.keys
      input_appli_keys = applicant_params.keys
      expect(result_appli_keys - input_appli_keys).to be_empty
      expect(input_appli_keys - result_appli_keys).to be_empty
    end
  end
end
