# frozen_string_literal: true

require 'spec_helper'
require 'shared_examples/aca_entities/fdsh/json_operations/response_magi_medicaid_application'

RSpec.describe AcaEntities::Fdsh::Ifsv::Rj9t::Operations::IfsvVerificationJsonResponse, dbclean: :after_each do
  include_context 'response magi medicaid application'

  context "in case of failure response" do
    let(:error_response_params) do
      {
        ifsvResponse: {
          responseMetadataArray: [
            {
              responseMetadata: {
                responseText: "Error responseText",
                responseCode: "HE042141",
                tdsResponseText: "gyr"
              }
            }
          ]
        }
      }
    end

    before do
      @result1 = described_class.new.call({ application_hash: application.to_h, response_payload: error_response_params })
    end

    it "result is successful" do
      expect(@result1.success?).to be_truthy
    end

    it "result contains an ifsvResponse with a nested responseMetadataArray" do
      result = @result1.value!

      expect(result).to have_key(:application_hash)
      expect(result).to have_key(:response_payload)
      expect(result[:response_payload]).to have_key(:ifsvResponse)
    end

    it "result contains a responseMetadataArray with error codes and messages" do
      error = @result1.value![:response_payload][:ifsvResponse][:responseMetadataArray].first

      expect(error[:responseMetadata]).to have_key(:responseText)
      expect(error[:responseMetadata]).to have_key(:responseCode)
    end
  end

  context "in case of success response" do
    let(:max_response_params) do
      {
        ifsvResponse: {
          requestID: '618578524',
          household: {
            aggregateTaxReturnIncomeAmount: 18.00,
            dependentVerificationArray: [],
            applicantVerificationArray: [
              {
                responseMetadataArray: [
                  {
                    responseMetadata: {
                      responseText: "KaiQThquTFOhr",
                      responseCode: "HE042141",
                      tdsResponseText: "gyr"
                    }
                  },
                  {
                    responseMetadata: {
                      responseText: "iVwAcleDMMYCGy",
                      responseCode: "HS948283",
                      tdsResponseText: "RJBOfna"
                    }
                  }
                ],
                taxReturn: {
                  taxReturnYear: 7869,
                  totalExemptionsQuantity: 79,
                  taxFilerSSN: "518124854",
                  taxReturnFilingStatusCode: "6",
                  taxableSocialSecurityBenefitsAmount: 42.00,
                  spouseSSN: "100529980",
                  taxReturnIncomeAmount: 13.00
                }
              }
            ]
          }
        }
      }
    end

    before do
      @result2 = described_class.new.call({ application_hash: application.to_h, response_payload: max_response_params })
    end

    it "is successful" do
      expect(@result2.success?).to be_truthy
    end

    it "result contains an application_hash as well as an ifsv_response with a nested :household and :requestID" do
      result = @result2.value!

      expect(result).to have_key(:application_hash)
      expect(result).to have_key(:response_payload)
      expect(result[:response_payload][:ifsvResponse]).to have_key(:household)
      expect(result[:response_payload][:ifsvResponse]).to have_key(:requestID)
    end
  end

  context "in case of invalid response" do
    let(:invalid_response_params) do
      {
        ifsvResponse: {
          requestID: 618_578_524,
          household: {
            aggregateTaxReturnIncomeAmount: 18.00,
            dependentVerificationArray: [],
            applicantVerificationArray: [
              {
                taxReturn: {
                  taxReturnYear: 7869,
                  taxFilerSSN: "518124854",
                  taxReturnFilingStatusCode: "6",
                  taxableSocialSecurityBenefitsAmount: 42.00,
                  spouseSSN: "100529980",
                  taxReturnIncomeAmount: 13.00
                }
              }
            ]
          }
        }
      }
    end

    before do
      @result3 = described_class.new.call({ application_hash: application.to_h, response_payload: invalid_response_params })
    end

    it "is not successful" do
      expect(@result3.success?).to be_falsey
    end
  end
end