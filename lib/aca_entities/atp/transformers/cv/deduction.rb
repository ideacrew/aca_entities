# frozen_string_literal: true

require 'aca_entities/atp/types'

module AcaEntities
  module Atp
    module Transformers
      module Cv
        # Transformers implementation for atp payloads
        class Deduction < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'category_code', 'code_kind', memoize: true, visible: false
          map 'category_text', 'text_kind', memoize: true, visible: false
          # kind can be passed in as category code or text, use code if present, otherwise use text
          add_key 'kind', function: lambda { |v|
            return nil unless v
            code_kind = v.resolve('code_kind').item
            text_kind = v.resolve('text_kind').item
            return AcaEntities::Atp::Types::DeductionKinds[code_kind] if code_kind
            return AcaEntities::Atp::Types::DeductionKinds[text_kind] if text_kind
          }
          map 'amount', 'amount'
          map 'earned_date_range.start_date.date', 'start_on'
          map 'earned_date_range.end_date.date', 'end_on'
          map 'frequency.frequency_code', 'frequency_kind', function: ->(v) {AcaEntities::Atp::Types::FrequencyCodeMap[v.downcase]}

        end
      end
    end
  end
end
