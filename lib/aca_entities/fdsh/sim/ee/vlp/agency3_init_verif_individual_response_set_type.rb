# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Agency3InitVerifIndividualResponseSetType
          class Agency3InitVerifIndividualResponseSetType < Dry::Struct

            attribute :caseNumber,                      Types::Strict::String.meta(omittable: false)
            attribute :nonCitLastName,                  Types::Strict::String.meta(omittable: true)
            attribute :nonCitFirstName,                 Types::Strict::String.meta(omittable: true)
            attribute :nonCitMiddleName,                Types::Strict::String.meta(omittable: true)
            attribute :nonCitBirthDate,                 Types::Strict::Date.meta(omittable: true)
            attribute :nonCitEntryDate,                 Types::Strict::Date.meta(omittable: true)
            attribute :nonCitAdmittedToDate,            Types::Strict::Date.meta(omittable: true)
            attribute :nonCitAdmittedToText,            Types::Strict::String.meta(omittable: true)
            attribute :nonCitCountryBirthCd,            Types::Strict::String.meta(omittable: true)
            attribute :nonCitCountryCitCd,              Types::Strict::String.meta(omittable: true)
            attribute :nonCitCoaCode,                   Types::Strict::String.meta(omittable: true)
            attribute :nonCitEadsExpireDate,            Types::Strict::Date.meta(omittable: true)
            attribute :eligStatementCd,                 Types::Strict::Integer.meta(omittable: false)
            attribute :eligStatementTxt,                Types::Strict::String.meta(omittable: false)
            attribute :iavTypeCode,                     Types::Strict::String.meta(omittable: true)
            attribute :iavTypeTxt,                      Types::Strict::String.meta(omittable: true)
            attribute :webServSftwrVer,                 Types::Strict::String.meta(omittable: false)
            attribute :grantDate,                       Types::Strict::Date.meta(omittable: true)
            attribute :grantDateReasonCd,               Types::Strict::String.meta(omittable: true)
            attribute :sponsorDataFoundIndicator,       Types::Strict::Bool.meta(omittable: true)
            attribute :arrayOfSponsorshipData,          Types::Array.of(Fdsh::Sim::Ee::Vlp::SponsorshipDataType).meta(omittable: true)
            attribute :sponsorshipReasonCd,             Types::Strict::String.meta(omittable: true)
            attribute :photoIncludedIndicator,          Types::Strict::Bool.meta(omittable: true)
            attribute :photoBinaryAttachment,           Types::Strict::String.meta(omittable: true) # TODO: type byte[]
            attribute :caseSentToSecondaryIndicator,    Types::Strict::Bool.meta(omittable: true)
            attribute :dshAutoTriggerStepTwo,           Types::Strict::Bool.meta(omittable: true)
            attribute :fiveYearBarApplyCode,            Types::Strict::String.meta(omittable: false)
            attribute :qualifiedNonCitizenCode,         Types::Strict::String.meta(omittable: false)
            attribute :fiveYearBarMetCode,              Types::Strict::String.meta(omittable: false)
            attribute :usCitizenCode,                   Types::Strict::String.meta(omittable: false)
          end
        end
      end
    end
  end
end