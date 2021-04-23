# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::QualifiedChild do
  describe 'with valid arguments' do
    let(:parent_caretaker_relationship) { { containing_person_is_qualified_for_parent_caretaker_status: 'N' } }
    let(:deprived_child) { { qualify_as_deprived_child: 'N' } }
    let(:determination) { { dependent_age: { is_person_of_dependent_age: 'N' } } }
    let(:qualified_child) do
      { person_id: 101,
        determination: determination,
        deprived_child: deprived_child,
        parent_caretaker_relationship: parent_caretaker_relationship }
    end

    before do
      contract_params = ::AcaEntities::MagiMedicaid::Mitc::Contracts::QualifiedChildContract.new.call(qualified_child).to_h
      @result = described_class.new(contract_params)
    end

    it 'should return qualified_child entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of qualified_child' do
      expect(@result.to_h.keys).to eq(qualified_child.keys)
    end

    it 'should match all the input keys of determination' do
      result_deter_keys = @result.to_h[:determination].keys
      input_deter_keys = determination.keys
      expect(result_deter_keys - input_deter_keys).to be_empty
      expect(input_deter_keys - result_deter_keys).to be_empty
    end

    it 'should match all the input keys of deprived_child' do
      result_dc_keys = @result.to_h[:deprived_child].keys
      input_dc_keys = deprived_child.keys
      expect(result_dc_keys - input_dc_keys).to be_empty
      expect(input_dc_keys - result_dc_keys).to be_empty
    end

    it 'should match all the input keys of parent_caretaker_relationship' do
      result_pcr_keys = @result.to_h[:parent_caretaker_relationship].keys
      input_pcr_keys = parent_caretaker_relationship.keys
      expect(result_pcr_keys - input_pcr_keys).to be_empty
      expect(input_pcr_keys - result_pcr_keys).to be_empty
    end
  end
end
