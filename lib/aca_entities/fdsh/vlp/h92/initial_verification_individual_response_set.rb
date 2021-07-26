# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp InitialVerificationIndividualResponseSet
        class InitialVerificationIndividualResponseSet < Dry::Struct

          attribute :CaseNumber,                      Types::String.optional.meta(omittable: false)
          attribute :NonCitLastName,                  Types::String.optional.meta(omittable: true)
          attribute :NonCitFirstName,                 Types::String.optional.meta(omittable: true)
          attribute :NonCitMiddleName,                Types::String.optional.meta(omittable: true)
          attribute :NonCitBirthDate,                 Types::Date.optional.meta(omittable: true)
          attribute :NonCitEntryDate,                 Types::Date.optional.meta(omittable: true)
          attribute :AdmittedToDate,                  Types::Date.optional.meta(omittable: true)
          attribute :AdmittedToText,                  Types::String.optional.meta(omittable: true)
          attribute :NonCitCountryBirthCd,            Types::String.optional.meta(omittable: true)
          attribute :NonCitCountryCitCd,              Types::String.optional.meta(omittable: true)
          attribute :NonCitCoaCode,                   Types::String.optional.meta(omittable: true)
          attribute :NonCitProvOfLaw,                 Types::String.optional.meta(omittable: true)
          attribute :NonCitEadsExpireDate,            Types::Date.optional.meta(omittable: true)
          attribute :EligStatementCd,                 Types::Integer.optional.meta(omittable: false)
          attribute :EligStatementTxt,                Types::String.optional.meta(omittable: false)
          attribute :IAVTypeCode,                     Types::String.optional.meta(omittable: true)
          attribute :IAVTypeTxt,                      Types::String.optional.meta(omittable: true)
          attribute :WebServSftwrVer,                 Types::String.optional.meta(omittable: false)
          attribute :GrantDate,                       Types::Date.optional.meta(omittable: true)
          attribute :GrantDateReasonCd,               Types::String.optional.meta(omittable: true)
          attribute :SponsorDataFoundIndicator,       Types::Bool.optional.meta(omittable: true)
          attribute :ArrayOfSponsorshipData,          Fdsh::Vlp::H92::ArrayOfSponsorshipData.optional.meta(omittable: true)
          attribute :SponsorshipReasonCd,             Types::String.optional.meta(omittable: true)
          attribute :AgencyAction,                    Types::String.optional.meta(omittable: true)
          attribute :FiveYearBarApplyCode,            Types::String.optional.meta(omittable: true)
          attribute :QualifiedNonCitizenCode,         Types::String.optional.meta(omittable: true)
          attribute :FiveYearBarMetCode,              Types::String.optional.meta(omittable: true)
          attribute :USCitizenCode,                   Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end