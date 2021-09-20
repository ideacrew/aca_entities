# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        # Contract for RRV IndividualRequestContract
        class IndividualRequestContract < Dry::Validation::Contract
          params do
            required(:Applicant).filled(AcaEntities::Fdsh::Rrv::Medicare::ApplicantContract.params)
            required(:InsurancePolicy).filled(AcaEntities::Fdsh::Rrv::Medicare::InsurancePolicyContract.params)
          end
        end
      end
    end
  end
end