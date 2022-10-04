# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # Validation schema for EligibilityItem
      class EligibilitySetContract < Dry::Validation::Contract
        params do
          optional(:id).maybe(:string)
          required(:key).filled(:symbol)
          optional(:title).maybe(:string)
          optional(:description).maybe(:string)

          required(:eligibilities).array(AcaEntities::Eligibilities::Contracts::EligibilityItemContract.params)
          optional(:tags).array(:string)
          optional(:published_at).maybe(:date_time)
        end
      end
    end
  end
end
