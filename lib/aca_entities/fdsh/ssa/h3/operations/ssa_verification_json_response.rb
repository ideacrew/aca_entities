# frozen_string_literal: true

require 'json'
require "json-schema"

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        module Operations
          # convert CMS response into CV3 response
          class SsaVerificationJsonResponse
            include Dry::Monads[:result, :do, :try]

            def call(params)
              validated_payload = yield validate_payload(params)
              metadata = yield construct_response_metadata(validated_payload.dig(:ssaCompositeResponse, :responseMetadata))
              responses = yield get_individual_responses(validated_payload.dig(:ssaCompositeResponse, :ssaCompositeIndividualResponseArray))
              response_payload = yield construct_params(metadata, responses)
              validate_response_payload(response_payload)
            end

            private

            def validate_payload(payload)
              schema_data = JSON.parse(File.read(Pathname.pwd.join("lib/aca_entities/fdsh/ssa/h3/schemas/SSAC-Response-Schema.json")))

              result = begin
                JSON::Validator.fully_validate(schema_data, JSON.parse(payload.to_json))
              rescue JSON::Schema::ValidationError => e
                e.message
              end
              result.empty? ? Success(payload) : Failure(result.to_s)
            end

            def construct_response_metadata(metadata)
              return Success(nil) unless metadata

              Success({
                        ResponseCode: metadata[:responseCode],
                        ResponseDescriptionText: metadata[:responseText],
                        TDSResponseDescriptionText: metadata[:tdsResponseText]
                      })
            end

            def get_individual_responses(individual_responses)
              return nil unless individual_responses

              responses = individual_responses.collect do |individual_response|
                metadata_result = construct_response_metadata(individual_response[:responseMetadata])
                metadata = metadata_result.success? ? metadata_result.value! : nil
                {
                  ResponseMetadata: metadata,
                  PersonSSNIdentification: individual_response[:personSocialSecurityNumber],
                  SSAResponse: construct_ssa_response(individual_response[:ssaResponse])
                }
              end

              Success(responses)
            end

            def construct_ssa_response(ssa_response)
              return nil unless ssa_response

              {
                SSNVerificationIndicator: ssa_response[:ssnVerificationIndicator],
                DeathConfirmationCode: ssa_response[:deathConfirmationCode],
                PersonUSCitizenIndicator: ssa_response[:personUSCitizenIndicator],
                PersonIncarcerationInformationIndicator: ssa_response[:personIncarcerationInformationIndicator],
                SSATitleIIMonthlyIncomeInformationIndicator: ssa_response[:ssaTitleIIMonthlyIncomeInformationIndicator],
                SSATitleIIAnnualIncomeInformationIndicator: ssa_response[:ssaTitleIIAnnualIncomeInformationIndicator],
                SSAQuartersOfCoverageInformationIndicator: ssa_response[:ssaQuartersOfCoverageInformationIndicator],
                SSAIncarcerationInformation: construct_incarceration_info(ssa_response[:ssaIncarcerationInformation]),
                SSATitleIIMonthlyIncome: construct_monthly_income(ssa_response[:ssaTitleIIMonthlyIncome]),
                SSATitleIIYearlyIncome: construct_yearly_income(ssa_response[:ssaTitleIIYearlyIncome]),
                SSAQuartersOfCoverage: construct_quarterly_coverage(ssa_response[:ssaQuartersOfCoverage])
              }
            end

            def construct_incarceration_info(incarceration_info)
              return nil unless incarceration_info

              {
                PrisonerIdentification: incarceration_info[:prisonerIdentification],
                PrisonerConfinementDate: incarceration_info[:prisonerConfinementDate],
                ReportingPersonText: incarceration_info[:reportingPersonText],
                SupervisionFacility: construct_facility_info(incarceration_info[:supervisionFacility]),
                InmateStatusIndicator: incarceration_info[:inmateStatusIndicator]
              }
            end

            def construct_facility_info(facility)
              return nil unless facility

              {
                FacilityName: facility[:facilityName],
                FacilityLocation: construct_facility_location(facility),
                FacilityContactInformation: construct_facility_contact_info(facility),
                FacilityCategoryCode: facility[:facilityCategoryCode]
              }
            end

            def construct_facility_location(facility)
              return nil unless facility

              {
                LocationStreet: facility[:facilityLocationStreet],
                LocationCityName: facility[:facilityLocationCityName],
                LocationStateUSPostalServiceCode: facility[:facilityLocationStateCode],
                LocationPostalCode: facility[:facilityLocationPostalCode]
              }
            end

            def construct_facility_contact_info(facility)
              return nil unless facility

              {
                PersonFullName: facility[:facilityContactPersonFullName],
                ContactTelephoneNumber: facility[:facilityContactTelephoneNumber],
                ContactFaxNumber: facility[:facilityContactFaxNumber]
              }
            end

            def construct_monthly_income(income)
              return nil unless income

              {
                PersonDisabledIndicator: income[:personDisabledIndicator],
                OngoingMonthlyBenefitCreditedAmount: income[:ongoingMonthlyBenefitCreditedAmount],
                OngoingMonthlyOverpaymentDeductionAmount: income[:ongoingMonthlyOverpaymentDeductionAmount],
                OngoingPaymentInSuspenseIndicator: income[:ongoingPaymentInSuspenseIndicator],
                RequestedMonthInformation: construct_requested_month_info(income[:requestedMonthInformation]),
                RequestedMonthMinusOneInformation: construct_requested_month_info(income[:requestedMonthMinusOneInformation]),
                RequestedMonthMinusTwoInformation: construct_requested_month_info(income[:requestedMonthMinusTwoInformation]),
                RequestedMonthMinusThreeInformation: construct_requested_month_info(income[:requestedMonthMinusThreeInformation])
              }
            end

            def construct_requested_month_info(monthly_info)
              return nil unless monthly_info

              # possibly need to add the following pieces of info to contract/entity: netMonthlyBenefitCreditedAmount,
              # monthlyIncomeAmount as they are in the new schemas

              {
                IncomeMonthYear: monthly_info[:incomeMonthYear],
                BenefitCreditedAmount: monthly_info[:benefitCreditedAmount],
                OverpaymentDeductionAmount: monthly_info[:overpaymentDeductionAmount],
                PriorMonthAccrualAmount: monthly_info[:priorMonthAccrualAmount],
                ReturnedCheckAmount: monthly_info[:returnedCheckAmount],
                PaymentInSuspenseIndicator: monthly_info[:paymentInSuspenseIndicator]
              }
            end

            def construct_yearly_income(income)
              return nil unless income

              {
                TitleIIRequestedYearInformation: {
                  IncomeDate: income[:incomeYear],
                  YearlyIncomeAmount: income[:yearlyIncomeAmount]
                }
              }
            end

            def construct_quarterly_coverage(coverage)
              return nil unless coverage
              {
                LifeTimeQuarterQuantity: coverage[:lifeTimeQuarterQuantity],
                QualifyingYearAndQuarterArray: construct_qualifying_year_array(coverage[:qualifyingYearAndQuarterArray])
              }
            end

            def construct_qualifying_year_array(qualifiers)
              return nil unless qualifiers

              qualifiers.collect do |qualifier|
                {
                  QualifyingYear: qualifier[:qualifyingYear].to_s,
                  QualifyingQuarter: qualifier[:qualifyingQuarter].to_s
                }
              end
            end

            def construct_params(metadata, responses)
              result_hash = {
                ResponseMetadata: metadata,
                SSACompositeIndividualResponses: responses
              }

              Success(result_hash)
            end

            def validate_response_payload(payload)
              result = ::AcaEntities::Fdsh::Ssa::H3::SSACompositeResponseContract.new.call(payload)

              if result.success?
                Success(payload)
              else
                Failure("Invalid response, #{result.errors.to_h}")
              end
            end
          end
        end
      end
    end
  end
end