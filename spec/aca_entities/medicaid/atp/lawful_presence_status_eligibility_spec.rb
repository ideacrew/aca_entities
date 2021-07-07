# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/lawful_presence_status_eligibility'

RSpec.describe ::AcaEntities::Medicaid::Atp::LawfulPresenceStatusEligibility,  dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) { { eligibility_indicator: true } }

    let(:optional_params) { { eligibility_basis_status_code: "Complete" } }

    let(:input_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:eligibility_indicator is missing in Hash input/)
    end
  end
end

