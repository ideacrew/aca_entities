# frozen_string_literal: true

require 'spec_helper'
require 'shared_examples/aca_entities/fdsh/json_operations/response_magi_medicaid_application'

RSpec.describe AcaEntities::Fdsh::Esi::Rj14::Operations::EsiMecJsonResponse, dbclean: :after_each do
  include_context 'response magi medicaid application'

  let(:response_params) do
    {
      esiMECResponse: {
        applicantResponseArray: [
          {
            applicantMECInformation: {
              requestedCoveragePeriod: {
                endDate: "2020-10-31",
                startDate: "2019-12-31"
              },
              employeeMonthlyPremiumAmount: 138.75,
              inconsistencyIndicator: false,
              applicantInsuredIndicator: true,
              applicantEligibleESIIndicator: true
            },
            responseMetadata: {
              responseText: "Success",
              responseCode: "HS000000"
            },
            personSocialSecurityNumber: "518124854"
          }
        ]
      }
    }
  end

  let(:response_params_2) do
    {
      esiMECResponse: {
        applicantResponseArray: [
          {
            applicantMECInformation: {
              requestedCoveragePeriod: {
                endDate: "2020-10-31",
                startDate: "2019-12-31"
              },
              employeeMonthlyPremiumAmount: 138.75,
              inconsistencyIndicator: true,
              applicantInsuredIndicator: true,
              applicantEligibleESIIndicator: true
            },
            responseMetadata: {
              responseText: "Success",
              responseCode: "HS000000"
            },
            personSocialSecurityNumber: "518124854"
          }
        ]
      }
    }
  end

  before do
    @result = described_class.new.call({ application_hash: application.to_h, response_payload: response_params })
  end

  it "is successful" do
    expect(@result.success?).to be_truthy
  end

  it "result to be an Application object" do
    expect(@result.value!).to be_a AcaEntities::MagiMedicaid::Application
  end

  it "evidence should be in outstanding state" do
    applicant = @result.value!.applicants.first
    expect(applicant.esi_evidence.aasm_state).to eq 'outstanding'
  end

  it "evidence should be in attested state if inconsistancy indicator is true" do
    @result2 = described_class.new.call({ application_hash: application.to_h, response_payload: response_params_2 })
    applicant = @result2.value!.applicants.first
    expect(applicant.esi_evidence.aasm_state).to eq 'attested'
  end
end
