# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Contracts::Documents::VlpDocumentContract, dbclean: :after_each do

  let(:vlp_documents) do
    {
      title: "untitled",
      creator: "dchl",
      subject: "Naturalization Certificate",
      publisher: "dchl",
      contributor: nil,
      date: nil,
      type: "text",
      format: "application/octet-stream",
      identifier: nil,
      source: "enroll_system",
      language: "en",
      relation: nil,
      coverage: nil,
      rights: nil,
      tags: [], size: nil,
      doc_identifier: nil,
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
      description: 'it is a test description',
      status: "not submitted",
      verification_type: "Citizenship",
      comment: nil
    }
  end

  context "with invalid params" do
    it "should fail validation" do
      result = subject.call(vlp_documents.reject { |k, _v| k == :title })
      expect(result.success?).to be_falsey
      expect(result.errors.to_h).to eq({ :title => ["is missing"] })
    end
  end

  context "and all required and optional parameters" do
    it "should pass validation" do
      result = subject.call(vlp_documents)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq vlp_documents
    end
  end
end
