# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        module Json
          # Entity for Fdsh JSON ssaCompositeIndividualRequest
          class SsaCompositeIndividualRequest < Dry::Struct
            attribute :personSocialSecurityNumber, Types::String.meta(omittable: false)
            attribute :personGivenName, Types::String.meta(omittable: false)
            attribute :personMiddleName, Types::String.optional.meta(omittable: true)
            attribute :personSurName, Types::String.meta(omittable: false)
            attribute :personBirthDate, Types::Date.meta(omittable: false)
            attribute :requestCitizenshipVerificationIndicator, Types::Bool.meta(omittable: false)
            attribute :requestIncarcerationVerificationIndicator, Types::Bool.meta(omittable: false)
            attribute :requestTitleIIMonthlyIncomeVerificationIndicator, Types::Bool.meta(omittable: false)
            attribute :requestTitleIIAnnualIncomeVerificationIndicator, Types::Bool.meta(omittable: false)
            attribute :requestQuartersOfCoverageVerificationIndicator, Types::Bool.meta(omittable: false)
            attribute :requestTitleIIMonthlyIncomeDate, Types::Date.optional.meta(omittable: true)
            attribute :requestTitleIIAnnualIncomeDate, Types::Date.optional.meta(omittable: true)
          end
        end
      end
    end
  end
end