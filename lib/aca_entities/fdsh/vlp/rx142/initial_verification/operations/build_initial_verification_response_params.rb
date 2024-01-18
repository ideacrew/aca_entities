# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx142
        module InitialVerification
          module Operations
            # FDSH constructs params based on serialized vlp response
            class BuildInitialVerificationResponseParams
              include Dry::Monads[:result, :do, :try]

              def call(payload)
                construct_params(payload)
              end

              def construct_params(parsed_xml)
                result_hash = {
                  ResponseMetadata: construct_response_metadata(parsed_xml&.ResponseMetadata),
                  InitialVerificationResponseSet: get_individual_verification_response_set(parsed_xml.InitialVerificationResponseSet)
                }

                Success(result_hash)
              end

              def get_individual_verification_response_set(response_set)
                {
                  InitialVerificationIndividualResponses: response_set.InitialVerificationIndividualResponses.collect do |individual_response|
                    {
                      ResponseMetadata: construct_response_metadata(individual_response&.ResponseMetadata),
                      ArrayOfErrorResponseMetadata: construct_error_response_metadata(individual_response.ArrayOfErrorResponseMetadata),
                      LawfulPresenceVerifiedCode: individual_response.LawfulPresenceVerifiedCode,
                      # rubocop:disable Layout/LineLength
                      InitialVerificationIndividualResponseSet: get_individual_response_set(individual_response.InitialVerificationIndividualResponseSet)
                      # rubocop:enable Layout/LineLength
                    }.compact
                  end
                }
              end

              # rubocop:disable Metrics/MethodLength
              def get_individual_response_set(individual_response_set)
                {
                  CaseNumber: individual_response_set&.CaseNumber,
                  NonCitLastName: individual_response_set&.NonCitLastName,
                  NonCitFirstName: individual_response_set&.NonCitFirstName,
                  NonCitMiddleName: individual_response_set&.NonCitMiddleName,
                  NonCitBirthDate: individual_response_set&.NonCitBirthDate,
                  NonCitEntryDate: individual_response_set&.NonCitEntryDate,
                  AdmittedToDate: individual_response_set&.AdmittedToDate,
                  AdmittedToText: individual_response_set&.AdmittedToText,
                  NonCitCountryBirthCd: individual_response_set&.NonCitCountryBirthCd,
                  NonCitCountryCitCd: individual_response_set&.NonCitCountryCitCd,
                  NonCitCoaCode: individual_response_set&.NonCitCoaCode,
                  NonCitProvOfLaw: individual_response_set&.NonCitProvOfLaw,
                  NonCitEadsExpireDate: individual_response_set&.NonCitEadsExpireDate,
                  EligStatementCd: individual_response_set&.EligStatementCd,
                  EligStatementTxt: individual_response_set&.EligStatementTxt,
                  IAVTypeCode: individual_response_set&.IAVTypeCode,
                  IAVTypeTxt: individual_response_set&.IAVTypeTxt,
                  WebServSftwrVer: individual_response_set&.WebServSftwrVer,
                  GrantDate: individual_response_set&.GrantDate,
                  GrantDateReasonCd: individual_response_set&.GrantDateReasonCd,
                  SponsorDataFoundIndicator: individual_response_set&.SponsorDataFoundIndicator,
                  ArrayOfSponsorshipData: construct_sponsorship_data(individual_response_set&.ArrayOfSponsorshipData),
                  SponsorshipReasonCd: individual_response_set&.SponsorshipReasonCd,
                  AgencyAction: individual_response_set&.AgencyAction,
                  FiveYearBarApplyCode: individual_response_set&.FiveYearBarApplyCode,
                  QualifiedNonCitizenCode: individual_response_set&.QualifiedNonCitizenCode,
                  FiveYearBarMetCode: individual_response_set&.FiveYearBarMetCode,
                  USCitizenCode: individual_response_set&.USCitizenCode
                }
              end
              # rubocop:enable Metrics/MethodLength

              def construct_sponsorship_data(sponsorship_data_array)
                return nil unless sponsorship_data_array

                sponsorship_data_array.SponsorshipData.collect do |sponsorship_data|
                  {
                    LastName: sponsorship_data.LastName,
                    FirstName: sponsorship_data.FirstName,
                    MiddleName: sponsorship_data.MiddleName,
                    Addr1: sponsorship_data.Addr1,
                    Addr2: sponsorship_data.Addr2,
                    City: sponsorship_data.City,
                    StateProvince: sponsorship_data.StateProvince,
                    ZipPostalCode: sponsorship_data.ZipPostalCode,
                    SSN: sponsorship_data.SSN,
                    CountryCode: sponsorship_data.CountryCode,
                    CountryName: sponsorship_data.CountryName
                  }
                end
              end

              def construct_response_metadata(metadata)
                {
                  ResponseCode: metadata&.ResponseCode,
                  ResponseDescriptionText: metadata&.ResponseDescriptionText,
                  TDSResponseDescriptionText: metadata&.TDSResponseDescriptionText
                }
              end

              def construct_error_response_metadata(error_metadata_array)
                return nil unless error_metadata_array

                error_metadata_array.ErrorResponseMetadata.collect do |error_metadata|
                  {
                    ErrorResponseCode: error_metadata&.ErrorResponseCode,
                    ErrorResponseDescriptionText: error_metadata&.ErrorResponseDescriptionText,
                    ErrorTDSResponseDescriptionText: error_metadata&.ErrorTDSResponseDescriptionText
                  }
                end
              end
            end
          end
        end
      end
    end
  end
end