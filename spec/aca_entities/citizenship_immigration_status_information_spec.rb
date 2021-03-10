# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/citizenship_immigration_status_information'

RSpec.describe ::AcaEntities::CitizenshipImmigrationStatusInformation, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:required_params) { { us_citizen: false } }

    let(:optional_params) do
      { naturalized_citizen: true,
        sevis_id: '123456789',
        same_name: true,
        eligible_immigration_status: true,
        is_resident_pre_1996: false }
    end

    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:us_citizen is missing in Hash input/)
    end
  end
end
