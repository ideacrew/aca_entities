# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for BaseCompensationInfoType
        class BaseCompensationInfoTypeContract < Dry::Validation::Contract
          params do
            optional(:pay_rate).maybe(:float)
            optional(:pay_frequency_code).maybe(AcaEntities::Fdsh::Ridp::H139::Types::PayFrequencyCodeSimpleKind)
            optional(:pay_frequency_message).maybe(:string)
            optional(:pay_period_frequency_code).maybe(AcaEntities::Fdsh::Ridp::H139::Types::PayPeriodFrequencyCodeSimplekind)
            optional(:pay_period_frequency_message).maybe(:string)
            optional(:annualized_income).maybe(:float)
          end
        end
      end
    end
  end
end