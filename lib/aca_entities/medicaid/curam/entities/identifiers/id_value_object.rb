# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Identifiers
        # IdValueObject
        class IdValueObject < Sequent::ValueObject
          attrs aggregate_id: String, key: String, item: String, start_on: DateTime, end_on: DateTime, label: String, description: String,
                identifiable_id: Integer, identifiable_type: String
        end
      end
    end
  end
end
