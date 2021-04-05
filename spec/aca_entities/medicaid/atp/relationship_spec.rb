# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/relationship'

RSpec.describe ::AcaEntities::Medicaid::Atp::Relationship, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:required_params) { { is_member_of_applicants_medicaid_household: false } }

    let(:optional_params) do
      { relationship_to_tax_filer_code: '01',
        attested_child_of_caretaker_code: 'YesCovered',
        absent_parent_code: 'Yes',
        attested_caretaker: true,
        lives_with_minor_age_dependent: false,
        lives_with_other_parent_not_claimer: false,
        person_for_work_quarters: false,
        parent_caretaker_to_child_relationship_code: '01',
        parent1_hours_worked_per_week: 10,
        parent2_hours_worked_per_week: 10,
        lives_with_household_member: false }
    end

    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end
end
