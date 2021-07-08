# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for Person.
      class PersonContract < Dry::Validation::Contract

        params do
          required(:id).filled(:string)
          required(:person_name).filled(:hash)
          required(:ssn_identification).filled(:hash)
          required(:sex).filled(:string)
          optional(:race).maybe(:string)
          optional(:ethnicities).maybe(:array)
          optional(:birth_date).maybe(:hash)
          optional(:person_augmentation).maybe(:hash)
          optional(:tribal_augmentation).maybe(:hash)
        end
      end
    end
  end
end
