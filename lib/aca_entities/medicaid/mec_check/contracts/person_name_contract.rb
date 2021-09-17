# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      module Contracts
        # Contract for PersonName
        class PersonNameContract < Dry::Validation::Contract

          params do
            required(:first_name).filled(:string)
            optional(:middle_name).maybe(:string)
            required(:last_name).filled(:string)
            optional(:name_suffix).maybe(:string)
          end
        end
      end
    end
  end
end