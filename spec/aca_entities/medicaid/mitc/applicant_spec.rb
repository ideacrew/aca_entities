# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/mitc/types'
require 'aca_entities/medicaid/mitc/relationship'
require 'aca_entities/medicaid/mitc/category_determination'
require 'aca_entities/medicaid/mitc/deprived_child'
require 'aca_entities/medicaid/mitc/qualified_child'
require 'aca_entities/medicaid/mitc/person_reference'
require 'aca_entities/medicaid/mitc/household'
require 'aca_entities/medicaid/mitc/applicant'

RSpec.describe ::AcaEntities::Medicaid::Mitc::Applicant do
  describe 'with valid arguments' do
    let(:medicaid_household_params) { { household_id: '1000', people: [{ person_id: 100 }] } }
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
    let(:input_params) do
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

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a ::AcaEntities::Medicaid::Mitc::Applicant
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
