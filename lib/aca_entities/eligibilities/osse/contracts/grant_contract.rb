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
            required(:key).filled(AcaEntities::Eligibilities::Types::GrantType)
            required(:value).filled(AcaEntities::Eligibilities::Osse::Contracts::ValueContract.params)
            required(:start_on).filled(:date)
            required(:end_on).filled(:date)
          end
        end
      end
    end
  end
end
