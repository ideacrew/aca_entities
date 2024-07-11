# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Documents::RidpDocument do

  let(:input_params) do
    {
      title: "license - back.pdf",
      creator: "mhc",
      subject: "license - back.pdf",
      description: nil,
      publisher: "mhc",
      contributor: nil,
      date: nil,
      type: "text",
      format: "application/octet-stream",
      identifier: nil, source: "enroll_system",
      language: "en", relation: nil, coverage: nil,
      rights: nil,
      tags: [],
      size: nil,
      doc_identifier: nil,
      status: "downloaded",
      ridp_verification_type: "Identity",
      comment: nil,
      uploaded_at: Date.today
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
      expect { described_class.new(input_params.reject { |k, _v| k == :status }) }.to raise_error(Dry::Struct::Error, /:status is missing/)
    end
  end
end
