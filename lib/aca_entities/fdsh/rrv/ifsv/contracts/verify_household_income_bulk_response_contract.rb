# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Contract for RRV Medicare
        class VerifyHouseholdIncomeBulkResponseContract < Dry::Validation::Contract
          params do
            optional(:IFSVApplicantResponseGrps).array(AcaEntities::Fdsh::Rrv::Ifsv::IfsvApplicantResponseGroupContract.params)
            optional(:ErrorMessageDetail).filled(AcaEntities::Fdsh::Rrv::Ifsv::ErrorMessageDetailContract.params)
          end
        end
      end
    end
  end
end