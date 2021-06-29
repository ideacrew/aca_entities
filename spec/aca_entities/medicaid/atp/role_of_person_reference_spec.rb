# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/role_of_person_reference'

RSpec.describe ::AcaEntities::Medicaid::Atp::RoleOfPersonReference, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) { { ref: "a-person-id" } }

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
