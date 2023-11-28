# frozen_string_literal: true

module AcaEntities
  module Cms
    module Pbp
      module Contracts
        # Schema and validation rules for the {Cms::Pbp::ProratedAmount} domain model
        class ProratedAmountContract < Dry::Validation::Contract
          params do
            required(:partial_month_premium).filled(AcaEntities::Types::Money)
            optional(:partial_month_aptc).maybe(AcaEntities::Types::Money)
            optional(:partial_month_csr).maybe(AcaEntities::Types::Money)
            required(:partial_month_start_date).filled(:date)
            required(:partial_month_end_date).filled(:date)
          end
        end
      end
    end
  end
end
