# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # contract for Fdsh Vlp InitialVerificationIndividualResponseSet
        class InitialVerificationIndividualResponseSetContract < Dry::Validation::Contract

          params do
            required(:CaseNumber).maybe(:string)
            optional(:NonCitLastName).maybe(:string)
            optional(:NonCitFirstName).maybe(:string)
            optional(:NonCitMiddleName).maybe(:string)
            optional(:NonCitBirthDate).maybe(:date)
            optional(:NonCitEntryDate).maybe(:date)
            optional(:AdmittedToDate).maybe(:date)
            optional(:AdmittedToText).maybe(:string)
            optional(:NonCitCountryBirthCd).maybe(:string)
            optional(:NonCitCountryCitCd).maybe(:string)
            optional(:NonCitCoaCode).maybe(:string)
            optional(:NonCitProvOfLaw).maybe(:string)
            optional(:NonCitEadsExpireDate).maybe(:date)
            required(:EligStatementCd).maybe(:integer)
            required(:EligStatementTxt).maybe(:string)
            optional(:IAVTypeCode).maybe(:string)
            optional(:IAVTypeTxt).maybe(:string)
            required(:WebServSftwrVer).maybe(:string)
            optional(:GrantDate).maybe(:date)
            optional(:GrantDateReasonCd).maybe(:string)
            optional(:SponsorDataFoundIndicator).maybe(:bool)
            optional(:ArrayOfSponsorshipData).maybe(Fdsh::Vlp::H92::ArrayOfSponsorshipDataContract.params)
            optional(:SponsorshipReasonCd).maybe(:string)
            optional(:AgencyAction).maybe(:string)
            optional(:FiveYearBarApplyCode).maybe(:string)
            optional(:QualifiedNonCitizenCode).maybe(:string)
            optional(:FiveYearBarMetCode).maybe(:string)
            optional(:USCitizenCode).maybe(:string)
          end
        end
      end
    end
  end
end