# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Fdsh::Ssa::H3::Operations::SsaVerificationJsonResponse, dbclean: :after_each do

  describe 'with valid arguments' do

    let!(:min_response) do
      {
        ssaCompositeResponse: {
          ssaCompositeIndividualResponseArray: [
            {
              responseMetadata: {
                responseText: "responseText",
                responseCode: "HS000000"
              },
              personSocialSecurityNumber: "100101000"
            }
          ],
          responseMetadata: {
            responseText: "responseText",
            responseCode: "HE123456"
          }
        }
      }
    end

    let!(:max_response) do
      {
        ssaCompositeResponse: {
          ssaCompositeIndividualResponseArray: [
            {
              responseMetadata: {
                responseText: "responseText",
                responseCode: "HS000000",
                tdsResponseText: "tdsResponseText"
              },
              ssaResponse: {
                ssaQuartersOfCoverage: {
                  qualifyingYearAndQuarterArray: [
                    {
                      qualifyingQuarter: 1,
                      qualifyingYear: 2007
                    },
                    {
                      qualifyingQuarter: 2,
                      qualifyingYear: 1987
                    }
                  ],
                  lifeTimeQuarterQuantity: 0
                },
                ssaIncarcerationInformation: {
                  supervisionFacility: {
                    facilityLocationCityName: "CityName",
                    facilityLocationStreet: "facilityLocationStreet",
                    facilityLocationPostalCode: "23456",
                    facilityContactPersonFullName: "facilityContactPersonFullName",
                    facilityContactFaxNumber: "455",
                    facilityName: "facilityName",
                    facilityCategoryCode: "01",
                    facilityContactTelephoneNumber: "123456789",
                    facilityLocationStateCode: "IA"
                  },
                  prisonerIdentification: "1234567890",
                  inmateStatusIndicator: false,
                  prisonerConfinementDate: "01222019",
                  reportingPersonText: "reportingPersonText"
                },
                ssnVerificationIndicator: false,
                deathConfirmationCode: "Confirmed",
                ssaQuartersOfCoverageInformationIndicator: false,
                personIncarcerationInformationIndicator: false,
                ssaTitleIIMonthlyIncomeInformationIndicator: false,
                ssaTitleIIAnnualIncomeInformationIndicator: false,
                ssaTitleIIMonthlyIncome: {
                  requestedMonthMinusThreeInformation: {
                    incomeMonthYear: "202007",
                    benefitCreditedAmount: 200,
                    returnedCheckAmount: 123,
                    monthlyIncomeAmount: 1234,
                    priorMonthAccrualAmount: 543,
                    overpaymentDeductionAmount: 45,
                    paymentInSuspenseIndicator: false,
                    netMonthlyBenefitCreditedAmount: 67
                  },
                  personDisabledIndicator: false,
                  requestedMonthMinusTwoInformation: {
                    incomeMonthYear: "202010",
                    benefitCreditedAmount: 200,
                    returnedCheckAmount: 123,
                    monthlyIncomeAmount: 1234,
                    priorMonthAccrualAmount: 543,
                    overpaymentDeductionAmount: 45,
                    paymentInSuspenseIndicator: false,
                    netMonthlyBenefitCreditedAmount: 67
                  },
                  ongoingMonthlyOverpaymentDeductionAmount: 0,
                  ongoingPaymentInSuspenseIndicator: false,
                  requestedMonthMinusOneInformation: {
                    incomeMonthYear: "202009",
                    benefitCreditedAmount: 200,
                    returnedCheckAmount: 123,
                    monthlyIncomeAmount: 1234,
                    priorMonthAccrualAmount: 543,
                    overpaymentDeductionAmount: 45,
                    paymentInSuspenseIndicator: false,
                    netMonthlyBenefitCreditedAmount: 67
                  },
                  ongoingMonthlyBenefitCreditedAmount: 0,
                  requestedMonthInformation: {
                    incomeMonthYear: "202010",
                    benefitCreditedAmount: 200,
                    returnedCheckAmount: 123,
                    monthlyIncomeAmount: 1234,
                    priorMonthAccrualAmount: 543,
                    overpaymentDeductionAmount: 45,
                    paymentInSuspenseIndicator: false,
                    netMonthlyBenefitCreditedAmount: 67
                  }
                },
                ssaTitleIIYearlyIncome: {
                  yearlyIncomeAmount: 45_097,
                  incomeYear: "2019"
                },
                personUSCitizenIndicator: false
              },
              personSocialSecurityNumber: "100101000"
            },
            {
              responseMetadata: {
                responseText: "responseText",
                responseCode: "HS000000",
                tdsResponseText: "tdsResponseText"
              },
              ssaResponse: {
                ssaQuartersOfCoverage: {
                  qualifyingYearAndQuarterArray: [
                    {
                      qualifyingQuarter: 1,
                      qualifyingYear: 2045
                    },
                    {
                      qualifyingQuarter: 2,
                      qualifyingYear: 1987
                    }
                  ],
                  lifeTimeQuarterQuantity: 0
                },
                ssaIncarcerationInformation: {
                  supervisionFacility: {
                    facilityLocationCityName: "CityName",
                    facilityLocationStreet: "facilityLocationStreet",
                    facilityLocationPostalCode: "23456",
                    facilityContactPersonFullName: "facilityContactPersonFullName",
                    facilityContactFaxNumber: "455",
                    facilityName: "facilityName",
                    facilityCategoryCode: "01",
                    facilityContactTelephoneNumber: "123456789",
                    facilityLocationStateCode: "IA"
                  },
                  prisonerIdentification: "1234567890",
                  inmateStatusIndicator: false,
                  prisonerConfinementDate: "01222019",
                  reportingPersonText: "reportingPersonText"
                },
                ssnVerificationIndicator: false,
                deathConfirmationCode: "Confirmed",
                ssaQuartersOfCoverageInformationIndicator: false,
                personIncarcerationInformationIndicator: false,
                ssaTitleIIMonthlyIncomeInformationIndicator: false,
                ssaTitleIIAnnualIncomeInformationIndicator: false,
                ssaTitleIIMonthlyIncome: {
                  requestedMonthMinusThreeInformation: {
                    incomeMonthYear: "202007",
                    benefitCreditedAmount: 200,
                    returnedCheckAmount: 123,
                    monthlyIncomeAmount: 1234,
                    priorMonthAccrualAmount: 543,
                    overpaymentDeductionAmount: 45,
                    paymentInSuspenseIndicator: false,
                    netMonthlyBenefitCreditedAmount: 67
                  },
                  personDisabledIndicator: false,
                  requestedMonthMinusTwoInformation: {
                    incomeMonthYear: "202010",
                    benefitCreditedAmount: 200,
                    returnedCheckAmount: 123,
                    monthlyIncomeAmount: 1234,
                    priorMonthAccrualAmount: 543,
                    overpaymentDeductionAmount: 45,
                    paymentInSuspenseIndicator: false,
                    netMonthlyBenefitCreditedAmount: 67
                  },
                  ongoingMonthlyOverpaymentDeductionAmount: 0,
                  ongoingPaymentInSuspenseIndicator: false,
                  requestedMonthMinusOneInformation: {
                    incomeMonthYear: "202009",
                    benefitCreditedAmount: 200,
                    returnedCheckAmount: 123,
                    monthlyIncomeAmount: 1234,
                    priorMonthAccrualAmount: 543,
                    overpaymentDeductionAmount: 45,
                    paymentInSuspenseIndicator: false,
                    netMonthlyBenefitCreditedAmount: 67
                  },
                  ongoingMonthlyBenefitCreditedAmount: 0,
                  requestedMonthInformation: {
                    incomeMonthYear: "202010",
                    benefitCreditedAmount: 200,
                    returnedCheckAmount: 123,
                    monthlyIncomeAmount: 1234,
                    priorMonthAccrualAmount: 543,
                    overpaymentDeductionAmount: 45,
                    paymentInSuspenseIndicator: false,
                    netMonthlyBenefitCreditedAmount: 67
                  }
                },
                ssaTitleIIYearlyIncome: {
                  yearlyIncomeAmount: 45_097,
                  incomeYear: "2019"
                },
                personUSCitizenIndicator: false
              },
              personSocialSecurityNumber: "100101000"
            }
          ],
          responseMetadata: {
            responseText: "responseText",
            responseCode: "HS000000",
            tdsResponseText: "tdsResponseText"
          }
        }
      }
    end

    context 'with valid max response' do

      before do
        @result = subject.call(max_response)
      end

      it 'should return success' do
        expect(@result).to be_success
      end

      it 'should return a hash' do
        expect(@result.value!.class).to eq Hash
      end
    end

    context 'with valid min response' do

      before do
        @result = subject.call(min_response)
      end

      it 'should return success' do
        expect(@result).to be_success
      end

      it 'should return a hash' do
        expect(@result.value!.class).to eq Hash
      end
    end

    context 'with invalid response' do
      before do
        max_response[:ssaCompositeResponse][:ssaCompositeIndividualResponseArray][0][:personSocialSecurityNumber] = nil
        @result = subject.call(max_response)
      end

      it 'should return failure' do
        expect(@result).to be_failure
      end

      it 'should return a string' do
        expect(@result.failure.class).to eq String
      end
    end
  end
end
