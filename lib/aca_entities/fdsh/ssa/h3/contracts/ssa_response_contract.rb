# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification response contract
        class SSAResponseContract < Dry::Validation::Contract

          params do
            optional(:SSNVerificationIndicator).maybe(:bool)
            optional(:DeathConfirmationCode).maybe(:string)
            optional(:PersonUSCitizenIndicator).maybe(:bool)
            optional(:PersonIncarcerationInformationIndicator).maybe(:bool)
            optional(:SSATitleIIMonthlyIncomeInformationIndicator).maybe(:bool)
            optional(:SSATitleIIAnnualIncomeInformationIndicator).maybe(:bool)
            optional(:SSAQuartersOfCoverageInformationIndicator).maybe(:bool)
            optional(:SSAIncarcerationInformation).maybe(AcaEntities::Fdsh::Ssa::H3::SSAIncarcerationInformationContract.params)
            optional(:SSATitleIIMonthlyIncome).maybe(AcaEntities::Fdsh::Ssa::H3::SSATitleIIMonthlyIncomeContract.params)
            optional(:SSATitleIIYearlyIncome).maybe(AcaEntities::Fdsh::Ssa::H3::SSATitleIIYearlyIncomeContract.params)
            optional(:SSAQuartersOfCoverage).maybe(AcaEntities::Fdsh::Ssa::H3::SSAQuartersOfCoverageContract.params)
          end
        end
      end
    end
  end
end