# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Contract for RRV Medicare
        class IfsvApplicantResponseGroupContract < Dry::Validation::Contract
          params do
            required(:RequestId).filled(AcaEntities::Fdsh::Types::RequestIDType)
            optional(:AggregateHouseholdIncomeAmt).value(AcaEntities::Types::Money)
            optional(:IFSVApplicantVerifications).array(AcaEntities::Fdsh::Rrv::Ifsv::VerificationContract.params)
            optional(:IFSVDependentVerifications).array(AcaEntities::Fdsh::Rrv::Ifsv::VerificationContract.params)
            optional(:ErrorMessageDetails).array(AcaEntities::Fdsh::Rrv::Ifsv::ErrorMessageDetailContract.params)
          end
        end
      end
    end
  end
end