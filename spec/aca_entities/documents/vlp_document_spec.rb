# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Documents::VlpDocument do

  let(:input_params) do
    {
      title: "untitled",
      creator: "dchl",
      subject: "Naturalization Certificate",
      description: nil,
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
      _type: "VlpDocument",
      alien_number: "047122478",
      i94_number: nil,
      visa_number: nil,
      passport_number: nil,
      sevis_id: nil,
      naturalization_number: "30121997",
      receipt_number: nil,
      citizenship_number: nil,
      card_number: nil,
      country_of_citizenship: nil,
      expiration_date: nil,
      issuing_country: nil,
      status: "not submitted",
      verification_type: "Citizenship",
      comment: nil
    }
  end

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect do
        described_class.new(input_params.reject do |k, _v|
                              k == :subject
                            end)
      end.to raise_error(Dry::Struct::Error, /:subject is missing/)
    end
  end
end
