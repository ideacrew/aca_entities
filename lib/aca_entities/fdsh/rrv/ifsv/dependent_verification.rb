# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Entity for RRV IFSV Dependent Verification
        class DependentVerification < Dry::Struct
          attribute :IFSVApplicantVerification, AcaEntities::Fdsh::Rrv::Ifsv::Verification.optional.meta(omittable: true)
        end
      end
    end
  end
end