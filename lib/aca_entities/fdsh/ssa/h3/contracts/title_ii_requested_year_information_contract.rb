# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class TitleIIRequestedYearInformationContract < Dry::Validation::Contract

          params do
            required(:IncomeDate).filled(:string)
            required(:YearlyIncomeAmount).filled(:decimal)
          end
        end
      end
    end
  end
end