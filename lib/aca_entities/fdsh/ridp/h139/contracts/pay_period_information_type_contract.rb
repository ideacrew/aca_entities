# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for PayPeriodInformationType
        class PayPeriodInformationTypeContract < Dry::Validation::Contract
          params do
            required(:pay_period_end_date).filled(:date)
            required(:income_detail).filled(Fdsh::Ridp::H139::IncomeTypeContract.params)
          end
        end
      end
    end
  end
end