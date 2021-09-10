# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Contract for RRV Medicare
        class IfsvApplicantRequestGroupContract < Dry::Validation::Contract
          params do
            required(:RequestId).filled(AcaEntities::Fdsh::Types::RequestIDType)
            required(:ifsv_applicants).array(AcaEntities::Fdsh::Rrv::Ifsv::IfsvApplicantContract.params)
          end
        end
      end
    end
  end
end