# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Eligibility
      # contract for MagiPregnancyBasis
      class MagiPregnancyBasisContract < Dry::Validation::Contract

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
