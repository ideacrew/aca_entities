# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/vlp_document'

RSpec.describe ::AcaEntities::MagiMedicaid::VlpDocument, dbclean: :after_each do

  describe 'with valid arguments' do
    let(:input_params) do
      { subject: 'I-327 (Reentry Permit)',
        alien_number: "0110200",
        i94_number: "i94",
        visa_number: "93749h",
        passport_number: "L1201",
        sevis_id: "N010",
        naturalization_number: nil,
        receipt_number: nil,
        citizenship_number: nil,
        card_number: nil,
        country_of_citizenship: nil,
        expiration_date: Date.new(2022, 3, 8),
        issuing_country: "USA" }
    end

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end
end
