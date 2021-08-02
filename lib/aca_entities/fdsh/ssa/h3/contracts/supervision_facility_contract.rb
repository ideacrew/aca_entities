# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class SupervisionFacilityContract < Dry::Validation::Contract

          params do
            required(:FacilityName).filled(:string)
            required(:FacilityLocation).filled(AcaEntities::Fdsh::Ssa::H3::FacilityLocationContract.params)
            required(:FacilityContactInformation).filled(AcaEntities::Fdsh::Ssa::H3::FacilityContactInformationContract.params)
            required(:FacilityCategoryCode).filled(:string)
          end
        end
      end
    end
  end
end