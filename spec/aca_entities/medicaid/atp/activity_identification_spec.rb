# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/activity_identification'

RSpec.describe ::AcaEntities::Medicaid::Atp::ActivityIdentification,  dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) { { identification_id: "MET00000000001887090" } }

    let(:optional_params) do
      { identification_category_text: "",
        identification_jurisdiction: "ME" }
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