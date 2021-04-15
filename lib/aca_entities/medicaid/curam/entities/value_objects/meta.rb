# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ValueObjects
        # meta objects
        class Meta < Sequent::ValueObject
          attrs(
            payload: String
          )
        end
      end
    end
  end
end