# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Osse
      module Contracts
        # Validation schema for Grant
        class GrantContract < Dry::Validation::Contract
          params do
            required(:title).filled(:string)
            optional(:description).maybe(:string)
            required(:key).filled(:string)
            required(:value).filled(AcaEntities::Eligibilities::Osse::Contracts::ValueContract.params)
            required(:start_on).filled(:date)
            optional(:end_on).maybe(:date)
          end
        end
      end
    end
  end
end
