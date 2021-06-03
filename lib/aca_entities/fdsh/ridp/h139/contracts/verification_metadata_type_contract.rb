# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for VerificationMetadataType
        class VerificationMetadataTypeContract < Dry::Validation::Contract
          params do
            required(:verification_id).filled(:string)
          end
        end
      end
    end
  end
end