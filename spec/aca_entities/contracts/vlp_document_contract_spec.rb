# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/types'
require 'aca_entities/contracts/vlp_document_contract'

RSpec.describe AcaEntities::Contracts::VlpDocumentContract, dbclean: :after_each do

  let(:all_params) do
    {
      subject: 'I-327 (Reentry Permit)',
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
      issuing_country: "USA",
      description: 'it is a test description'
    }
  end

  context "with invalid params" do
    it "should fail validation" do
      result = subject.call({ expiration_date: "it is a date" })
      expect(result.success?).to be_falsey
      expect(result.errors.to_h).to eq({ :expiration_date => ["must be a date"] })
    end
  end

  context "and all required and optional parameters" do
    it "should pass validation" do
      result = subject.call(all_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end
end
