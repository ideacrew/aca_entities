# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Contract for RRV Medicare
        class VerificationContract < Dry::Validation::Contract
          params do
            optional(:TaxpayerIdentificationNumber).filled(:string)
            optional(:SpouseTIN).filled(:string)
            optional(:TaxYear).filled(:string)
            optional(:IndividualReturnFilingStatusCd).filled(:string)
            optional(:ComputerTaxableSocSecAmt).filled(AcaEntities::Types::Money)
            optional(:AdjustedGrossIncomeAmt).filled(AcaEntities::Types::Money)
            optional(:IncomeAmt).filled(AcaEntities::Types::Money)
            optional(:IFSVResponseCodeDetails).array(AcaEntities::Fdsh::Rrv::Ifsv::IfsvResponseCodeDetailContract.params)
          end
        end
      end
    end
  end
end