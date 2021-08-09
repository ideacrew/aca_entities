# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class SSAResponse < Dry::Struct
          attribute :SSNVerificationIndicator,  Types::Bool.optional.meta(omittable: true)
          attribute :DeathConfirmationCode,  Types::String.optional.meta(omittable: true)
          attribute :PersonUSCitizenIndicator,  Types::Bool.optional.meta(omittable: true)
          attribute :PersonIncarcerationInformationIndicator,  Types::Bool.optional.meta(omittable: true)
          attribute :SSATitleIIMonthlyIncomeInformationIndicator,  Types::Bool.optional.meta(omittable: true)
          attribute :SSATitleIIAnnualIncomeInformationIndicator,  Types::Bool.optional.meta(omittable: true)
          attribute :SSAQuartersOfCoverageInformationIndicator,  Types::Bool.optional.meta(omittable: true)
          attribute :SSAIncarcerationInformation,  AcaEntities::Fdsh::Ssa::H3::SSAIncarcerationInformation.optional.meta(omittable: true)
          attribute :SSATitleIIMonthlyIncome,  AcaEntities::Fdsh::Ssa::H3::SSATitleIIMonthlyIncome.optional.meta(omittable: true)
          attribute :SSATitleIIYearlyIncome,  AcaEntities::Fdsh::Ssa::H3::SSATitleIIYearlyIncome.optional.meta(omittable: true)
          attribute :SSAQuartersOfCoverage,  AcaEntities::Fdsh::Ssa::H3::SSAQuartersOfCoverage.optional.meta(omittable: true)
        end
      end
    end
  end
end