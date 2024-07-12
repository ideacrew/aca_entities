# frozen_string_literal: true

require 'spec_helper'
require 'shared_examples/aca_entities/fdsh/json_operations/response_magi_medicaid_application'

RSpec.describe AcaEntities::Fdsh::NonEsi::Rj31::Operations::NonEsiMecJsonResponse do
  include_context 'response magi medicaid application'

  context "in case of failure response" do
    let(:mini_response_params) do
      {
        verifyNonESIMECResponse: {
          responseMetadata: {
            responseText: "Error responseText",
            responseCode: "HE123456"
          }
        }
      }
    end

    before do
      @result1 = described_class.new.call({ application_hash: application.to_h, response_payload: mini_response_params })
    end

    it "is successful" do
      expect(@result1.success?).to be_truthy
    end

    it "result to be an Application object" do
      expect(@result1.value!).to be_a AcaEntities::MagiMedicaid::Application
    end

    it "evidence should be in attested state" do
      applicant = @result1.value!.applicants.first
      expect(applicant.non_esi_evidence.aasm_state).to eq 'attested'
    end
  end

  context "in case of success response" do
    let(:max_response_params) do
      {
        verifyNonESIMECResponse: {
          individualResponseArray: [
            {
              partialResponseIndicator: false,
              personSurName: "STEPHENS",
              personBirthDate: "1964-01-30",
              otherCoverageArray: [
                {
                  mecCoverage: {
                    mecVerificationCode: "Y",
                    insuranceArray: [
                      {
                        insurancePolicyExpirationDate: "2020-02-29",
                        insurancePolicyEffectiveDate: "2020-01-14"
                      },
                      {
                        insurancePolicyExpirationDate: "2020-09-17",
                        insurancePolicyEffectiveDate: "2020-01-21"
                      }
                    ],
                    usStateCode: "AK"
                  },
                  organizationCode: "MEDI",
                  responseMetadata: {
                    responseText: "Success",
                    responseCode: "HE000000",
                    tdsResponseText: "tdsResponseText"
                  }
                }
              ],
              personSexCode: "M",
              personSocialSecurityNumber: "518124854",
              personGivenName: "K",
              personMiddleName: "personMiddleName"
            }
          ]
        }
      }
    end

    before do
      @result2 = described_class.new.call({ application_hash: application.to_h, response_payload: max_response_params })
    end

    it "is successful" do
      expect(@result2.success?).to be_truthy
    end

    it "result to be an Application object" do
      expect(@result2.value!).to be_a AcaEntities::MagiMedicaid::Application
    end

    it "evidence should be in outstanding state" do
      applicant = @result2.value!.applicants.first
      expect(applicant.non_esi_evidence.aasm_state).to eq 'outstanding'
    end
  end
end
