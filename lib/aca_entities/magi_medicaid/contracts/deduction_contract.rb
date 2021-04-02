# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Deduction.
      class DeductionContract < Dry::Validation::Contract
        include ::AcaEntities::AppHelper

        params do
          optional(:name).maybe(:string)
          required(:kind).filled(Types::DeductionKind)
          required(:amount).filled(:float)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          required(:frequency_kind).filled(Types::DeductionFrequency)
          optional(:submitted_at).maybe(:date_time)
        end

        rule(:end_on) do
          key.failure(text: 'must be after start_on.') if key? && check_if_present?(value) && values[:start_on] && value < values[:start_on]
        end
      end
    end
  end
end
