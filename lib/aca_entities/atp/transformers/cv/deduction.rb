# frozen_string_literal: true

require 'aca_entities/atp/types'

module AcaEntities
  module Atp
    module Transformers
      module Cv
        # Transformers implementation for atp payloads
        class Deduction < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'category_code', 'kind', function: lambda { |v|
                                                   AcaEntities::Atp::Types::DeductionKinds[v]
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
