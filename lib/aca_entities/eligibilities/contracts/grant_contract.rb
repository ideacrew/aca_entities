# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # Validation schema for Grant
      class GrantContract < Dry::Validation::Contract
        params do
          required(:title).filled(:string)
          optional(:description).maybe(:string)
          required(:key).filled(AcaEntities::Eligibilities::Types::GrantType)
          required(:value).filled(:float)
          required(:assistance_year).filled(:integer)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          optional(:member_ids).array(:string)
          optional(:tax_household_group_id).maybe(:string)
          optional(:tax_household_id).maybe(:string)
        end
      end
    end
  end
end