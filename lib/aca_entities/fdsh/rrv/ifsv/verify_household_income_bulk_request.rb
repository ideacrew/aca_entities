# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Entity for RRV IFSV VerifyHouseholdIncomeBulkRequest
        class VerifyHouseholdIncomeBulkRequest < Dry::Struct
          attribute :ifsv_applicant_request_groups,  Types::Array.of(Fdsh::Rrv::Ifsv::IfsvApplicantRequestGroup).meta(omittable: false)
        end
      end
    end
  end
end