# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for Demographic.
      class DemographicContract < Dry::Validation::Contract

        params do
          required(:dob).filled(:date)
          required(:gender).filled(Types::GenderKind)
          optional(:is_veteran_or_active_military).maybe(:bool)
          optional(:age_of_applicant).maybe(:integer)
          optional(:date_of_adoption).maybe(:date)
          optional(:is_married).maybe(:bool)
          optional(:race_name).maybe(:string)
          optional(:ethnicity_name).maybe(:string)
          optional(:is_hispanic_or_spanish_descent).maybe(:bool)
        end

        rule(:is_married) do
          if key?
            # required if applicant/person is applyingForCoverage.
          end
        end
      end
    end
  end
end
