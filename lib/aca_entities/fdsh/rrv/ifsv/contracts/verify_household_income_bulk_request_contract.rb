# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Contract for RRV Medicare
        class VerifyHouseholdIncomeBulkRequestContract < Dry::Validation::Contract
          params do
            required(:IFSVApplicantRequestGrps).array(AcaEntities::Fdsh::Rrv::Ifsv::IfsvApplicantRequestGroupContract.params)
          end
        end
      end
    end
  end
end