# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class TaxReturn < Dry::Struct

        attribute :filers,      Types::Array.of(PersonReference).meta(omitttable: false)
        attribute :dependents,  Types::Array.of(PersonReference).meta(omitttable: false)

      end
    end
  end
end