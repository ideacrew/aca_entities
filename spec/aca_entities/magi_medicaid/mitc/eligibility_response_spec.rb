# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::EligibilityResponse do
  describe 'with valid arguments' do
    let(:medicaid_household_params) { { people: [{ person_id: 100 }], magi_income: 1000, size: 1 } }
    let(:category_determination_params) do
      { indicator_code: 'Y',
        ineligibility_code: 123,
        ineligibility_reason: 'Nothing' }
    end
    let(:qualified_child_params) do
      { person_id: 101,
        determination: { indicator_code: 'Y',
                         ineligibility_code: 123,
                         ineligibility_reason: 'Nothing' },
        deprived_child: { qualify_as_deprived_child: 'N' },
        relationship: { other_id: 100,
                        attest_primary_responsibility: 'Y',
                        relationship_code: '01' } }
    end
    let(:applicant_params) do
      { person_id: 100,
        medicaid_household: medicaid_household_params,
        is_medicaid_eligible: 'N',
        is_chip_eligible: 'N',
        medicaid_ineligibility_reasons: ['test'],
        is_eligible_for_non_magi_reasons: 'N',
        chip_ineligibility_reasons: ['test'],
        medicaid_category: 'Medicaid Category',
        medicaid_category_threshold: 100,
        chip_category: 'Chip Category',
        chip_category_threshold: 50,
        category_determination: category_determination_params,
        qualified_children: [qualified_child_params] }
    end
    let(:input_params) do
      { determination_date: Date.today.to_s, applicants: [applicant_params] }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a ::AcaEntities::MagiMedicaid::Mitc::EligibilityResponse
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end
end
