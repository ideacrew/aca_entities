# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Contract for RRV Medicare
        class IfsvApplicantContract < Dry::Validation::Contract
          params do
            required(:TaxpayerIdentificationNumber).filled(:string)
            required(:CompletePersonName).filled(AcaEntities::Fdsh::Rrv::Ifsv::CompletePersonNameContract.params)
            required(:FilerTypeCd).array(::AcaEntities::Fdsh::Ifsv::H9t::Types::TaxFilerCategoryCodeKind)
          end
        end
      end
    end
  end
end