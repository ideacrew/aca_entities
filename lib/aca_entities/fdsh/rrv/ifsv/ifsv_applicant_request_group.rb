# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Entity for RRV IFSV VerifyHouseholdIncomeBulkRequest
        class IfsvApplicantRequestGroup < Dry::Struct
          attribute :RequestId, AcaEntities::Fdsh::Types::RequestIDType.meta(omittable: false)
          attribute :IFSVApplicants,  Types::Array.of(Fdsh::Rrv::Ifsv::IfsvApplicant).meta(omittable: false)
        end
      end
    end
  end
end