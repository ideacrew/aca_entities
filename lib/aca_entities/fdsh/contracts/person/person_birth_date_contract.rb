# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Contracts
      module Person
        # FDSH schema and validation rules for {AcaEntities::Fdsh::Person::PersonBirthDate}
        class PersonBirthDateContract < AcaEntities::Fdsh::Contracts::Contract
          params do
            required(:Date).filled(:date)
          end
        end
      end
    end
  end
end
