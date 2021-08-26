# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3
            # Happymapper implementation for the root object of an
            # Request.
            class SSAResponse
              include HappyMapper
              register_namespace 'extn', 'http://extn.ssac.ee.sim.dsh.cms.hhs.gov'
              register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

              tag 'SSAResponse'
              namespace 'extn'

              element :SSNVerificationIndicator, Boolean, tag: 'SSNVerificationIndicator', namespace: "extn"
              element :DeathConfirmationCode, String, tag: 'DeathConfirmationCode', namespace: "extn"
              element :PersonUSCitizenIndicator, Boolean, tag: 'PersonUSCitizenIndicator', namespace: "nc"
              element :PersonIncarcerationInformationIndicator, Boolean, tag: 'PersonIncarcerationInformationIndicator', namespace: "extn"
              element :SSATitleIIMonthlyIncomeInformationIndicator, Boolean, tag: 'SSATitleIIMonthlyIncomeInformationIndicator', namespace: "extn"
              element :SSATitleIIAnnualIncomeInformationIndicator, Boolean, tag: 'SSATitleIIAnnualIncomeInformationIndicator', namespace: "extn"
              element :SSAQuartersOfCoverageInformationIndicator, Boolean, tag: 'SSAQuartersOfCoverageInformationIndicator', namespace: "extn"
              has_one :SSAIncarcerationInformation, SSAIncarcerationInformation
              has_one :SSATitleIIMonthlyIncome, SSATitleIIMonthlyIncome
              has_one :SSATitleIIYearlyIncome, SSATitleIIYearlyIncome
              has_one :SSAQuartersOfCoverage, SSAQuartersOfCoverage

              def self.domain_to_mapper(initial_request)
                mapper = self.new
                mapper.SSNVerificationIndicator = initial_request.SSNVerificationIndicator
                mapper.DeathConfirmationCode = initial_request.DeathConfirmationCode
                mapper.PersonUSCitizenIndicator = initial_request.PersonUSCitizenIndicator
                mapper.PersonIncarcerationInformationIndicator = initial_request.PersonIncarcerationInformationIndicator
                mapper.SSATitleIIMonthlyIncomeInformationIndicator = initial_request.SSATitleIIMonthlyIncomeInformationIndicator
                mapper.SSATitleIIAnnualIncomeInformationIndicator = initial_request.SSATitleIIAnnualIncomeInformationIndicator
                mapper.SSAQuartersOfCoverageInformationIndicator = initial_request.SSAQuartersOfCoverageInformationIndicator
                mapper.SSAIncarcerationInformation = SSAIncarcerationInformation.domain_to_mapper(initial_request.SSAIncarcerationInformation)
                mapper.SSATitleIIMonthlyIncome = SSATitleIIMonthlyIncome.domain_to_mapper(initial_request.SSATitleIIMonthlyIncome)
                mapper.SSATitleIIYearlyIncome = SSATitleIIYearlyIncome.domain_to_mapper(initial_request.SSATitleIIYearlyIncome)
                mapper.SSAQuartersOfCoverage = SSAQuartersOfCoverage.domain_to_mapper(initial_request.SSAQuartersOfCoverage)

                mapper
              end
            end
          end
        end
      end
    end
  end
end