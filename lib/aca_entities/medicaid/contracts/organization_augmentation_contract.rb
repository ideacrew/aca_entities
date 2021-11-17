# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Organization augmentation contract
      class OrganizationAugmentationContract < Dry::Validation::Contract
        params do
          optional(:tin_identification).maybe(:hash)
        end
      end
    end
  end
end