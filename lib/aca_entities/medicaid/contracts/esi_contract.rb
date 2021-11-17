# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for Esi
      class EsiContract < Dry::Validation::Contract

        params do
          optional(:lowest_cost_plan).maybe(:hash)
          optional(:via_current_employee_indicator).maybe(:bool)
        end
      end
    end
  end
end
