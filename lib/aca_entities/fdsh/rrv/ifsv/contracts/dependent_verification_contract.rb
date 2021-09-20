# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Contract for RRV Medicare
        class DependentVerificationContract < Dry::Validation::Contract
          params do
            optional(:IFSVApplicantVerification).array(::AcaEntities::Fdsh::Rrv::Ifsv::VerificationContract.params)
          end
        end
      end
    end
  end
end