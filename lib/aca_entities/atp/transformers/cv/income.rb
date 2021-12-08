# frozen_string_literal: true

require 'aca_entities/atp/types'

module AcaEntities
  module Atp
    module Transformers
      module Cv
        # Transformers implementation for atp payloads
        class Income < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'category_code', 'kind', function: ->(v) {AcaEntities::Atp::Types::IncomeKinds[v] || AcaEntities::Atp::Types::OtherIncomeKinds[v]}
          map 'amount', 'amount'
          map 'earned_date_range.start_date.date', 'start_on'
          map 'earned_date_range.end_date.date', 'end_on', function: ->(v) {v == "2021-12-31" ? nil : v } # omit problematic default value
          add_key 'amount_tax_exempt'
          map 'frequency.frequency_code', 'frequency_kind', function: ->(v) {AcaEntities::Atp::Types::FrequencyCodeMap[v.downcase]}
          add_key 'is_projected', value: nil # default
        end
      end
    end
  end
end
