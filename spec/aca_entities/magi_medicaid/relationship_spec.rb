# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe ::AcaEntities::MagiMedicaid::Relationship, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:applicant) do
      { first_name: 'First Test',
        last_name: 'Last Test',
        dob: Date.today.prev_year,
        person_hbx_id: '1000' }
    end

    let(:relative) do
      { first_name: 'Second Test',
        last_name: 'Last Test',
        dob: Date.today.prev_year,
        person_hbx_id: '1001' }
    end

    let(:input_params) do
      { kind: 'spouse',
        applicant_reference: applicant,
        relative_reference: relative }
    end

    before do
      relationship_params = AcaEntities::MagiMedicaid::Contracts::RelationshipContract.new.call(input_params).to_h
      @result = described_class.new(relationship_params)
    end

    it 'should return Relationship entity object' do
      expect(@result).to be_a(described_class)
    end

    it 'should return all keys of Relationship' do
      expect(@result.to_h.keys).to eq(input_params.keys)
    end

    it 'should match all the input keys of applicant_reference' do
      result_app_ref_keys = @result.to_h[:applicant_reference].keys
      input_app_ref_keys = applicant.keys
      expect(result_app_ref_keys - input_app_ref_keys).to be_empty
      expect(input_app_ref_keys - result_app_ref_keys).to be_empty
    end

    it 'should match all the input keys of relative_reference' do
      result_app_ref_keys = @result.to_h[:relative_reference].keys
      input_app_ref_keys = relative.keys
      expect(result_app_ref_keys - input_app_ref_keys).to be_empty
      expect(input_app_ref_keys - result_app_ref_keys).to be_empty
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:first_name is missing in Hash input/)
    end
  end
end
