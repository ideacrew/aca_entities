# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/signature_date'

RSpec.describe ::AcaEntities::Medicaid::Atp::SignatureDate,  dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      { date: Date.today,
        date_time: DateTime.now,
        year: "2021",
        year_month: "2021/12" }
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