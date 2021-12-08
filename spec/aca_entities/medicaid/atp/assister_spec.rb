# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/person_name'
require 'aca_entities/medicaid/atp/assister'

RSpec.describe ::AcaEntities::Medicaid::Atp::Assister,  dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      {
        role_played_by_person: role_played_by_person
      }
    end

    let(:role_played_by_person) do
      {
        person_name: person_name,
        sex: "SEX"
      }
    end

    let(:person_name) do
      { given: 'first',
        middle: 'middle',
        sur: 'last',
        full: 'prefix first middle last suffix' }
    end

    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end

    context 'with only optional parameters' do
      it 'should contain all optional keys and values' do
        result = described_class.new(optional_params)
        expect(result.to_h).to eq optional_params
      end
    end
  end
end