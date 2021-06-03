# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for BaseCompensationInfoType
        class BaseCompensationInfoType < Dry::Struct

          attribute :pay_rate,                       Types::Float.optional.meta(omittable: true)
          attribute :pay_frequency_code,
                    ::AcaEntities::Fdsh::Ridp::H139::Types::PayFrequencyCodeSimpleKind.optional.meta(omittable: true)
          attribute :pay_frequency_message,           Types::String.optional.meta(omittable: true)
          attribute :pay_period_frequency_code,
                    ::AcaEntities::Fdsh::Ridp::H139::Types::PayPeriodFrequencyCodeSimplekind.optional.meta(omittable: true)
          attribute :pay_period_frequency_message,     Types::String.optional.meta(omittable: true)
          attribute :annualized_income,              Types::Float.optional.meta(omittable: true)
        end
      end
    end
  end
end