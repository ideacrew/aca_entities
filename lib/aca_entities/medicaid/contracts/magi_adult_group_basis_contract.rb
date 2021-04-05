# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for MagiAdultGroupBasis
      class MagiAdultGroupBasisContract < Dry::Validation::Contract

        params do
          required(:category_code).filled(:string)
          optional(:category_indicator).maybe(:bool)
          optional(:determination_date).maybe(:date_time)
          optional(:ineligibility_reason).maybe(:string)
        end
      end
    end
  end
end
