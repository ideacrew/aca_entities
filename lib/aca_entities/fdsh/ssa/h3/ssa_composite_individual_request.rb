# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSA VerificationRequest
        class SSACompositeIndividualRequest < Dry::Struct

          attribute :Person,                                         Fdsh::Ssa::H3::Person.meta(omittable: false)
          attribute :RequestCitizenshipVerificationIndicator,        Types::Bool.meta(omittable: false)
          attribute :RequestIncarcerationVerificationIndicator,        Types::Bool.meta(omittable: false)
          attribute :RequestTitleIIMonthlyIncomeVerificationIndicator,  Types::Bool.meta(omittable: false)
          attribute :RequestTitleIIAnnualIncomeVerificationIndicator,  Types::Bool.meta(omittable: false)
          attribute :RequestQuartersOfCoverageVerificationIndicator,  Types::Bool.meta(omittable: false)
          attribute :RequestTitleIIMonthlyIncomeDate,  Types::Date.optional.meta(omittable: true)
          attribute :RequestTitleIIAnnualIncomeDate,  Types::Date.optional.meta(omittable: true)
        end
      end
    end
  end
end