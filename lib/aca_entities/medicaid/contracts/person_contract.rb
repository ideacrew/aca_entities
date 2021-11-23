# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for Person.
      class PersonContract < Dry::Validation::Contract

        params do
          required(:id).filled(:string)
          optional(:age_measure).maybe(:hash)
          optional(:birth_date).maybe(:hash)
          optional(:ethnicities).maybe(:array)
          required(:person_name).filled(:hash)
          optional(:race).maybe(:string)
          required(:sex).filled(:string)
          required(:ssn_identification).filled(:hash)
          optional(:us_citizen_indicator).maybe(:bool)
          optional(:living_indicator).maybe(:bool)
          optional(:person_augmentation).maybe(:hash)
          optional(:tribal_augmentation).maybe(:hash)
        end
      end
    end
  end
end
