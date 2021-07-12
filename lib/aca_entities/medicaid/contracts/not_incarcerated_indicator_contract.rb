# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # NotIncarceratedIndicator information contract
      class NotIncarceratedIndicatorContract < Dry::Validation::Contract
        params do
          required(:value).filled(:bool)
          optional(:metadata).maybe(:string)
        end
      end
    end
  end
end