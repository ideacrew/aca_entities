# frozen_string_literal: true

require "spec_helper"

RSpec.describe ::AcaEntities::Fdsh::Ridp::H139::SecondaryRequest do
  let(:params) do
    {
      VerificationAnswerSet: {
        VerificationAnswers: [
          { VerificatonAnswer: 1, VerificationQuestionNumber: 1 },
          { VerificatonAnswer: 4, VerificationQuestionNumber: 2 },
          { VerificatonAnswer: 2, VerificationQuestionNumber: 3 }
        ]
      }
    }.merge(session_identifier).merge(reference_number)
  end

  let(:session_identifier) { { SessionIdentification: "123456789" } }
  let(:reference_number) { { DSHReferenceNumber: "123456789" } }

  describe "with valid arguments" do
    it "should initialize" do
      expect(described_class.new(params)).to be_a described_class
    end

    it "should not raise error" do
      expect { described_class.new(params) }.not_to raise_error
    end
  end

  describe "with invalid arguments" do
    context "when session identification missing" do
      let(:session_identifier) { {} }

      it "should raise error" do
        expect { described_class.new(params) }.to raise_error(
          Dry::Struct::Error,
          /:SessionIdentification is missing/
        )
      end
    end

    context "when session identification missing" do
      let(:reference_number) { {} }

      it "should raise error" do
        expect { described_class.new(params) }.to raise_error(
          Dry::Struct::Error,
          /:DSHReferenceNumber is missing/
        )
      end
    end
  end
end
