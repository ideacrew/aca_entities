# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class SSAIncarcerationInformationContract < Dry::Validation::Contract

          params do
            required(:PrisonerIdentification).filled(:string)
            required(:PrisonerConfinementDate).filled(:string)
            required(:ReportingPersonText).filled(:string)
            required(:SupervisionFacility).filled(AcaEntities::Fdsh::Ssa::H3::SupervisionFacilityContract.params)
            required(:InmateStatusIndicator).filled(:bool)
          end
        end
      end
    end
  end
end