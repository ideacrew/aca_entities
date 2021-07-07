# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for Person.
      class PersonContract < Dry::Validation::Contract

        params do
          required(:person_name).filled(:hash)
          required(:ssn).filled(:string)
          required(:sex).filled(:string)
          optional(:race).maybe(:string)
          optional(:ethnicity).maybe(:array)
          optional(:birth_date).maybe(:hash)
          optional(:person_augmentation).maybe(:hash)
          optional(:tribal_augmentation).maybe(:hash)
        end
      end
    end
  end
end
