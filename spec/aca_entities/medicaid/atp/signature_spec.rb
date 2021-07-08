# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/signature_date'
require 'aca_entities/medicaid/atp/signature'

RSpec.describe ::AcaEntities::Medicaid::Atp::Signature,  dbclean: :around_each do
  
  describe 'with valid arguments' do
    let(:all_params) { { date_time: { date: Date.today } } }

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end
end