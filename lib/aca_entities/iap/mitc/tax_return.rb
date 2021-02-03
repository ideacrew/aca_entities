# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      class TaxReturn < Dry::Struct

        attribute :filers,      Array.of(PersonReference).meta(omitttable: false)
        attribute :dependents,  Array.of(PersonReference).meta(omitttable: false)

      end
    end
  end
end