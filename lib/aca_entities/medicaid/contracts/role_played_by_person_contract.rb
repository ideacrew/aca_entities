# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for RolePlayedByPerson.
      class RolePlayedByPersonContract < Dry::Validation::Contract

        params do
          required(:person_name).filled(:hash)
          optional(:birth_date).maybe(:hash)
          optional(:sex).maybe(:string)
          optional(:person_augmentation).maybe(:hash)
        end
      end
    end
  end
end
