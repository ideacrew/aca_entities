# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # response.
            class InitialVerificationIndividualResponseSet
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'InitialVerificationIndividualResponseSet'
              namespace 'vlp'

              element :CaseNumber, String, tag: 'CaseNumber', namespace: 'vlp'
              element :NonCitLastName, String, tag: 'NonCitLastName', namespace: 'vlp'
              element :NonCitFirstName, String, tag: 'NonCitFirstName', namespace: 'vlp'
              element :NonCitMiddleName, String, tag: 'NonCitMiddleName', namespace: 'vlp'
              element :NonCitBirthDate, String, tag: 'NonCitBirthDate', namespace: 'vlp'
              element :NonCitEntryDate, String, tag: 'NonCitEntryDate', namespace: 'vlp'
              element :AdmittedToDate, String, tag: 'AdmittedToDate', namespace: 'vlp'
              element :AdmittedToText, String, tag: 'AdmittedToText', namespace: 'vlp'
              element :NonCitCountryBirthCd, String, tag: 'NonCitCountryBirthCd', namespace: 'vlp'
              element :NonCitCountryCitCd, String, tag: 'NonCitCountryCitCd', namespace: 'vlp'
              element :NonCitCoaCode, String, tag: 'NonCitCoaCode', namespace: 'vlp'
              element :NonCitProvOfLaw, String, tag: 'NonCitProvOfLaw', namespace: 'vlp'
              element :NonCitEadsExpireDate, String, tag: 'NonCitEadsExpireDate', namespace: 'vlp'
              element :EligStatementCd, String, tag: 'EligStatementCd', namespace: 'vlp'
              element :EligStatementTxt, String, tag: 'EligStatementTxt', namespace: 'vlp'
              element :IAVTypeCode, String, tag: 'IAVTypeCode', namespace: 'vlp'
              element :IAVTypeTxt, String, tag: 'IAVTypeTxt', namespace: 'vlp'
              element :WebServSftwrVer, String, tag: 'WebServSftwrVer', namespace: 'vlp'
              element :GrantDate, String, tag: 'GrantDate', namespace: 'vlp'
              element :GrantDateReasonCd, String, tag: 'GrantDateReasonCd', namespace: 'vlp'
              element :SponsorDataFoundIndicator, String, tag: 'SponsorDataFoundIndicator', namespace: 'vlp'
              has_one :ArrayOfSponsorshipData, ArrayOfSponsorshipData
              element :SponsorshipReasonCd, String, tag: 'SponsorshipReasonCd', namespace: 'vlp'
              element :AgencyAction, String, tag: 'AgencyAction', namespace: 'vlp'
              element :FiveYearBarApplyCode, String, tag: 'FiveYearBarApplyCode', namespace: 'vlp'
              element :QualifiedNonCitizenCode, String, tag: 'QualifiedNonCitizenCode', namespace: 'vlp'
              element :FiveYearBarMetCode, String, tag: 'FiveYearBarMetCode', namespace: 'vlp'
              element :USCitizenCode, String, tag: 'USCitizenCode', namespace: 'vlp'

              # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
              def self.domain_to_mapper(individual_response_set)
                mapper = self.new
                mapper.CaseNumber = individual_response_set.CaseNumber
                mapper.NonCitLastName = individual_response_set.NonCitLastName
                mapper.NonCitFirstName = individual_response_set.NonCitFirstName
                mapper.NonCitMiddleName = individual_response_set.NonCitMiddleName
                mapper.NonCitBirthDate = individual_response_set.NonCitBirthDate.strftime
                mapper.NonCitEntryDate = individual_response_set.NonCitEntryDate.strftime
                mapper.AdmittedToDate = individual_response_set.AdmittedToDate.strftime
                mapper.AdmittedToText = individual_response_set.AdmittedToText
                mapper.NonCitCountryBirthCd = individual_response_set.NonCitCountryBirthCd
                mapper.NonCitCountryCitCd = individual_response_set.NonCitCountryCitCd
                mapper.NonCitCoaCode = individual_response_set.NonCitCoaCode
                mapper.NonCitProvOfLaw = individual_response_set.NonCitProvOfLaw
                mapper.NonCitEadsExpireDate = individual_response_set.NonCitEadsExpireDate.strftime
                mapper.EligStatementCd = individual_response_set.EligStatementCd
                mapper.EligStatementTxt = individual_response_set.EligStatementTxt
                mapper.IAVTypeCode = individual_response_set.IAVTypeCode
                mapper.IAVTypeTxt = individual_response_set.IAVTypeTxt
                mapper.WebServSftwrVer = individual_response_set.WebServSftwrVer
                mapper.GrantDate = individual_response_set.GrantDate.strftime
                mapper.GrantDateReasonCd = individual_response_set.GrantDateReasonCd
                mapper.SponsorDataFoundIndicator = individual_response_set.SponsorDataFoundIndicator
                mapper.ArrayOfSponsorshipData = ArrayOfSponsorshipData.domain_to_mapper(individual_response_set.ArrayOfSponsorshipData)
                mapper.SponsorshipReasonCd = individual_response_set.SponsorshipReasonCd
                mapper.AgencyAction = individual_response_set.AgencyAction
                mapper.FiveYearBarApplyCode = individual_response_set.FiveYearBarApplyCode
                mapper.QualifiedNonCitizenCode = individual_response_set.QualifiedNonCitizenCode
                mapper.FiveYearBarMetCode = individual_response_set.FiveYearBarMetCode
                mapper.USCitizenCode = individual_response_set.USCitizenCode

                mapper
              end
              # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
            end
          end
        end
      end
    end
  end
end
