# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/person_augmentation'
require 'aca_entities/medicaid/atp/person_name'
require 'aca_entities/medicaid/atp/person_birth_date'
require 'aca_entities/medicaid/atp/role_played_by_person'

RSpec.describe ::AcaEntities::Medicaid::Atp::RolePlayedByPerson, dbclean: :after_each do

  let(:required_params) do
    {
      person_name: person_name,
      sex: "SEX"
    }
  end

  let(:optional_params) do
    {
      birth_date: person_birth_date,
      person_augmentation: person_augmentation
    }
  end

  let(:person_name) do
    { given: 'first',
      middle: 'middle',
      sur: 'last',
      full: 'prefix first middle last suffix' }
  end

  let(:person_birth_date) do
    { date: Date.today - 50 }
  end

  let(:person_augmentation) do
    {}
  end

  let(:all_params) { required_params.merge(optional_params)}

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect { described_class.new }.to raise_error(Dry::Struct::Error, /:given is missing in Hash input/)
      end
    end

    context 'with optional parameters only' do
      it 'should list error for every required parameter' do
        expect { described_class.new(optional_params) }.to raise_error(Dry::Struct::Error, /:person_name is missing in Hash input/)
      end
    end
  end

  context 'valid parameters' do
    context 'with required parameters only' do
      it 'should initialize' do
        expect(described_class.new(required_params)).to be_a described_class
      end

      it 'should not raise error' do
        expect { described_class.new(required_params) }.not_to raise_error
      end
    end

    context 'with all required and optional parameters' do
      it 'should initialize' do
        expect(described_class.new(required_params)).to be_a described_class
      end

      it 'should not raise error' do
        expect { described_class.new(required_params) }.not_to raise_error
      end
    end
  end
end
