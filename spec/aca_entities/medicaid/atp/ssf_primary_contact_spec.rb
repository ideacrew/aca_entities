# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/role_of_person_reference'
require 'aca_entities/medicaid/atp/ssf_primary_contact'

RSpec.describe ::AcaEntities::Medicaid::Atp::SsfPrimaryContact, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { role_reference: { ref: "a-person-id" },
        contact_preference: "Email" }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { subject }.to raise_error(Dry::Struct::Error, /:ref is missing in Hash input/)
    end
  end
end
