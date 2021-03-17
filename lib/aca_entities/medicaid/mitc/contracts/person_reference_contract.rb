# frozen_string_literal: true

module AcaEntities
  module Medicaid
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
