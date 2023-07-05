# frozen_string_literal: true

module AcaEntities
  module People
    module IvlOsseEligibility
      # contract for ShopOsseEligibility::AdminAttestedEvidence
      class AdminAttestedEvidenceContract < Dry::Validation::Contract
        params do
          required(:key).filled(:symbol)
          required(:title).filled(:string)
          optional(:description).maybe(:string)
          required(:is_satisfied).filled(:bool)
          required(:state_histories).filled(:array)
          optional(:timestamps).filled(
            AcaEntities::Contracts::TimeStampContract.params
          )
        end

        rule(:state_histories).each do
          if key? && value
            result = AcaEntities::Eligible::StateHistoryContract.new.call(value)
            if result&.failure?
              key.failure(
                text: 'invalid state history',
                error: result.errors.to_h
              )
            end
          end
        end
      end
    end
  end
end
