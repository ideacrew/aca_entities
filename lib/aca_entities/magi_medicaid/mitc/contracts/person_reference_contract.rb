# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Contract for PersonReference.
        class PersonReferenceContract < Dry::Validation::Contract

          params do
            required(:person_id).filled(:integer)
          end
        end
      end
    end
  end
end
