# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Applications
        module ValueObjects
          # ProgramApplication class
          class ProgramApplication < Sequent::ValueObject
            attrs(
              aggregate_id: String,
              program_type: String,
              status: String,
              last_updated_at: DateTime,
              meta: ::Curam::ValueObjects::Meta
            )
          end
        end
      end
    end
  end
end