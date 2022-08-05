# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # Validation schema for Grant
      class GrantContract < Dry::Validation::Contract
        params do
          required(:premium_adjustment_grant).filled(AcaEntities::Eligibilities::Types::PremiumAdjustmentGrantType)
          optional(:subject).maybe(:string)
          required(:value).filled(:float)
          required(:start_on).filled(:date)
          required(:end_on).filled(:date)
        end
      end
    end
  end
end
