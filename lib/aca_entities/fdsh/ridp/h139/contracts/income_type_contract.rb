# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for IncomeType
        class IncomeTypeContract < Dry::Validation::Contract

          params do
            optional(:income_amount).maybe(:float)
            optional(:income_hours_per_week_measure).maybe(:integer)
            optional(:income_date).maybe(:date)
            optional(:income_net_payment_amount).maybe(:float)
          end
        end
      end
    end
  end
end