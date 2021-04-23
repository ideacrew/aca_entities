# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/mitc_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Mitc::OtherOutput do
  describe 'with valid arguments' do
    let(:qualified_child) do
      { person_id: 101,
        determination: { dependent_age: { is_person_of_dependent_age: 'N' } },
        deprived_child: { qualify_as_deprived_child: 'N' },
        parent_caretaker_relationship: { containing_person_is_qualified_for_parent_caretaker_status: 'N' } }
    end

    let(:other_output) do
      { qualified_children_list: [qualified_child] }
    end

    before do
      contract_params = ::AcaEntities::MagiMedicaid::Mitc::Contracts::OtherOutputContract.new.call(other_output).to_h
      @result = described_class.new(contract_params)
    end

    it 'should return other_output entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of other_output' do
      expect(@result.to_h.keys).to eq(other_output.keys)
    end

    it 'should match all the input keys of qualified_child' do
      result_qc_keys = @result.to_h[:qualified_children_list].first.keys
      input_qc_keys = qualified_child.keys
      expect(result_qc_keys - input_qc_keys).to be_empty
      expect(input_qc_keys - result_qc_keys).to be_empty
    end
  end
end
