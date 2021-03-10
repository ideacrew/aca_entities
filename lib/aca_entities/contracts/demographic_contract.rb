# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for Demographic.
    class DemographicContract < Dry::Validation::Contract

      params do
        required(:dob).filled(:date)
        required(:gender).filled(Types::GenderKind)
        optional(:is_veteran_or_active_military).maybe(:bool)
        optional(:age_of_applicant).maybe(:integer)
      end
    end
  end
end
