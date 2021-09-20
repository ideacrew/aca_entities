# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Entity for RRV IFSV Verification
        class Verification < Dry::Struct
          attribute :TaxpayerIdentificationNumber, AcaEntities::Types::String.optional.meta(omittable: true)
          attribute :SpouseTIN, AcaEntities::Types::String.optional.meta(omittable: true)
          attribute :TaxYear, AcaEntities::Types::String.optional.meta(omittable: true)
          attribute :IndividualReturnFilingStatusCd, AcaEntities::Types::String.optional.meta(omittable: true)
          attribute :ComputerTaxableSocSecAmt, AcaEntities::Types::Money.optional.meta(omittable: true)
          attribute :AdjustedGrossIncomeAmt, AcaEntities::Types::Money.optional.meta(omittable: true)
          attribute :IncomeAmt, AcaEntities::Types::Money.optional.meta(omittable: true)
          attribute :TotalExemptionsCnt, AcaEntities::Types::Integer.optional.meta(omittable: true)
          attribute :IFSVResponseCodeDetails, Types::Array.of(AcaEntities::Fdsh::Rrv::Ifsv::IfsvResponseCodeDetail).optional.meta(omittable: true)
        end
      end
    end
  end
end