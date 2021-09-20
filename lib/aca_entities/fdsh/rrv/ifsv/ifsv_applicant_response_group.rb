# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Entity for RRV IFSV VerifyHouseholdIncomeBulkRequest
        class IfsvApplicantResponseGroup < Dry::Struct
          attribute :RequestId, AcaEntities::Fdsh::Types::RequestIDType.meta(omittable: false)
          attribute :AggregateHouseholdIncomeAmt, AcaEntities::Types::Money.optional.meta(omittable: true)
          attribute :IFSVApplicantVerifications, Types::Array.of(AcaEntities::Fdsh::Rrv::Ifsv::Verification).optional.meta(omittable: true)
          attribute :IFSVDependentVerifications, Types::Array.of(AcaEntities::Fdsh::Rrv::Ifsv::DependentVerification).optional.meta(omittable: true)
          attribute :ErrorMessageDetails,        Types::Array.of(AcaEntities::Fdsh::Rrv::Ifsv::ErrorMessageDetail).optional.meta(omittable: true)
        end
      end
    end
  end
end