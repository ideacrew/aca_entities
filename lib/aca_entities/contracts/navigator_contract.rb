# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for Navigator.
    class NavigatorContract < Dry::Validation::Contract

      params do
        optional(:first_name).maybe(:string)
        optional(:middle_name).maybe(:string)
        required(:last_name).filled(:string)
        optional(:suffix).maybe(:string)
        optional(:organization_name).maybe(:string)
        optional(:organization_id).maybe(:string)
        optional(:broker_user_id).maybe(:string)
        optional(:broker_npn).maybe(:string)
        required(:designation_date).filled(:date)
      end

      rule(:designation_date) do
        if key? && value && (value <= 1912 || value.year > Date.today.year)
          key.failure(text: 'Designation date is invalid')
        end
      end
    end
  end
end
