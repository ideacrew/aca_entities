# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Medicare
        # Contract for PVC IndividualRequestContract
        class IndividualRequestContract < Dry::Validation::Contract
          params do
            required(:Applicant).filled(AcaEntities::Fdsh::Pvc::Medicare::ApplicantContract.params)
            required(:InsurancePolicy).filled(AcaEntities::Fdsh::Pvc::Medicare::InsurancePolicyContract.params)
          end
        end
      end
    end
  end
end