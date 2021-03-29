# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Demographic.
      class DemographicContract < Dry::Validation::Contract

        params do
          required(:gender).filled(Types::GenderKind)
          required(:dob).filled(:date)
          optional(:ethnicity).array(:string)
          optional(:race).maybe(:string)
          optional(:is_veteran_or_active_military).maybe(:bool)
          optional(:is_vets_spouse_or_child).maybe(:bool)
        end
      end
    end
  end
end
