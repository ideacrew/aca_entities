# frozen_string_literal: true

require "spec_helper"

RSpec.describe ::AcaEntities::Fdsh::Ridp::H139::SecondaryRequestContract do
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

  context "Given invalid parameter scenarios" do
    context "when session identification missing" do
      let(:session_identifier) { {} }

      it "should list error for every required parameter" do
        result = subject.call(params)

        expect(result.success?).to be_falsey
        expect(result.errors.to_h).to include(SessionIdentification: ["is missing"])
      end
    end

    context "when reference number missing" do
      let(:reference_number) { {} }

      it "should list error for every required parameter" do
        result = subject.call(params)

        expect(result.success?).to be_falsey
        expect(result.errors.to_h).to include(DSHReferenceNumber: ["is missing"])
      end
    end
  end

  context "Given valid parameters" do
    context "and all required parameters" do
      it "should pass validation" do
        result = subject.call(params)

        expect(result.success?).to be_truthy
        expect(result.to_h).to eq params
      end
    end
  end
end
