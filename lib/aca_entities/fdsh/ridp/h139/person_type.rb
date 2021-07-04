# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for IncomeType
        class PersonType < Dry::Struct

          attribute :person_name,                     Types::String.meta(omittable: false)
          attribute :Person_birth_date,               Types::Date.meta(omittable: false)
          attribute :person_ssn_identification,       Types::String.meta(omittable: false)

        end
      end
    end
  end
end