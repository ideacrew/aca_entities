# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for EsiAugmentation
      class EsiAugmentationContract < Dry::Validation::Contract

        params do
          optional(:esi).maybe(:hash)
        end
      end
    end
  end
end
