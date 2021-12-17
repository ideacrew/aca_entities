# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Enrollees
      # Schema and validation rules for Glue {AcaEntities::Enrollees::SegmentContract} .
      class SegmentContract < Dry::Validation::Contract
        params do
          required(:id).filled(:string)
          required(:effective_start_date).filled(:date)
          required(:effective_end_date).filled(:date)
          optional(:individual_premium_amount).maybe(:float)
          optional(:individual_responsible_amount).maybe(:float)
          optional(:total_premium_amount).maybe(:float)
          optional(:total_responsible_amount).maybe(:float)
          optional(:aptc_amount).maybe(:float)
          optional(:csr_variant).maybe(:string)
        end
      end
    end
  end
end
