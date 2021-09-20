# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Entity for RRV IFSV VerifyHouseholdIncomeBulkRequest
        class IfsvApplicant < Dry::Struct
          attribute :TaxpayerIdentificationNumber, AcaEntities::Types::String.meta(omittable: false)
          attribute :CompletePersonName,  Fdsh::Rrv::Ifsv::CompletePersonName.meta(omittable: false)
          attribute :FilerTypeCd, ::AcaEntities::Fdsh::Ifsv::H9t::Types::TaxFilerCategoryCodeKind.meta(omittable: false)
        end
      end
    end
  end
end