# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ValueObjects
        # External Identifier
        class ExternalIdentifier < Sequent::ValueObject
          attrs(
            key: String,
            item: String,
            start_on: DateTime
          )
        end
      end
    end
  end
end