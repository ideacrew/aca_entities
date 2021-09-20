# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Ifsv
            # Happymapper implementation for the root object of an Request.
            class IfsvApplicantVerification
              include HappyMapper
              register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

              tag 'IFSVApplicantVerification'

              element :TaxpayerIdentificationNumber, String, tag: 'TaxpayerIdentificationNumber', namespace: "irs"
              element :SpouseTIN, String, tag: 'SpouseTIN', namespace: "irs"
              element :TaxYear, String, tag: 'TaxYear', namespace: "irs"
              element :IndividualReturnFilingStatusCd, String, tag: 'IndividualReturnFilingStatusCd', namespace: "irs"
              element :ComputerTaxableSocSecAmt, String, tag: 'ComputerTaxableSocSecAmt', namespace: "irs"
              element :AdjustedGrossIncomeAmt, Float, tag: 'AdjustedGrossIncomeAmt', namespace: "irs"
              element :TotalExemptionsCnt, Integer, tag: 'TotalExemptionsCnt', namespace: "irs"
              has_many :IFSVResponseCodeDetail, IfsvResponseCodeDetail

              def self.domain_to_mapper(verification)
                mapper = self.new

                mapper.TaxpayerIdentificationNumber = verification.TaxpayerIdentificationNumber
                mapper.SpouseTIN = verification.SpouseTIN
                mapper.TaxYear = verification.TaxYear
                mapper.IndividualReturnFilingStatusCd = verification.IndividualReturnFilingStatusCd
                mapper.ComputerTaxableSocSecAmt = verification.ComputerTaxableSocSecAmt
                mapper.AdjustedGrossIncomeAmt = verification.AdjustedGrossIncomeAmt
                mapper.TotalExemptionsCnt = verification.TotalExemptionsCnt
                mapper.IFSVResponseCodeDetail = IfsvResponseCodeDetail.domain_to_mapper(applicant.IFSVResponseCodeDetail)

                mapper
              end
            end
          end
        end
      end
    end
  end
end
