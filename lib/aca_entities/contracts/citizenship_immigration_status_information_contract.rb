# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for CitizenshipImmigrationStatusInformation.
    class CitizenshipImmigrationStatusInformationContract < Dry::Validation::Contract

      params do
        required(:us_citizen).filled(:bool)
        optional(:naturalized_citizen).maybe(:bool)
        optional(:sevis_id).maybe(:string)
        optional(:same_name).maybe(:bool)
        optional(:eligible_immigration_status).maybe(:bool)
        optional(:is_resident_pre_1996).maybe(:bool)
      end

      rule(:us_citizen) do
        key.failure(text: 'eligible_immigration_status must be answered') if key? && value == false && values[:eligible_immigration_status].nil?
      end
    end
  end
end
