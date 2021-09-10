# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Entity for RRV IFSV VerifyHouseholdIncomeBulkRequest
        class VerifyHouseholdIncomeBulkResponse < Dry::Struct
          attribute :IfsvApplicantResponseGroups,
                    Types::Array.of(AcaEntities::Fdsh::Rrv::Ifsv::IfsvApplicantResponseGroup).optional.meta(omittable: true)
          attribute :ErrorMessageDetail,  AcaEntities::Fdsh::Rrv::Ifsv::ErrorMessageDetail.optional.meta(omittable: true)
        end
      end
    end
  end
end