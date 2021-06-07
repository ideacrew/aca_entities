# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # contract for Fdsh Vlp Agency3InitVerifIndividualResponseSetType
          class Agency3InitVerifIndividualResponseSetTypeContract < Dry::Validation::Contract

            params do
              required(:caseNumber).filled(:string)
              required(:eligStatementCd).filled(:integer)
              required(:eligStatementTxt).filled(:string)
              required(:webServSftwrVer).filled(:string)
              required(:fiveYearBarApplyCode).filled(:string)
              required(:qualifiedNonCitizenCode).filled(:string)
              required(:fiveYearBarMetCode).filled(:string)
              required(:usCitizenCode).filled(:string)

              optional(:nonCitLastName).maybe(:string)
              optional(:nonCitFirstName).maybe(:string)
              optional(:nonCitMiddleName).maybe(:string)
              optional(:nonCitBirthDate).maybe(:date)
              optional(:nonCitEntryDate).maybe(:date)
              optional(:nonCitAdmittedToDate).maybe(:date)
              optional(:nonCitAdmittedToText).maybe(:string)
              optional(:nonCitCountryBirthCd).maybe(:string)
              optional(:nonCitCountryCitCd).maybe(:string)
              optional(:nonCitCoaCode).maybe(:string)
              optional(:nonCitEadsExpireDate).maybe(:date)
              optional(:iavTypeCode).maybe(:string)
              optional(:iavTypeTxt).maybe(:string)
              optional(:grantDate).maybe(:date)
              optional(:grantDateReasonCd).maybe(:string)
              optional(:sponsorDataFoundIndicator).maybe(:bool)
              optional(:arrayOfSponsorshipData).array(Fdsh::Sim::Ee::Vlp::SponsorshipDataContract.params)
              optional(:sponsorshipReasonCd).maybe(:string)
              optional(:photoIncludedIndicator).maybe(:bool)
              optional(:photoBinaryAttachment).maybe(:string)
              optional(:caseSentToSecondaryIndicator).maybe(:bool)
              optional(:dshAutoTriggerStepTwo).maybe(:bool)
            end
          end
        end
      end
    end
  end
end