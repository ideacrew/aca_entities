# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Expense < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          add_key 'category_text'
          map 'amount', 'amount'
          map 'frequency_kind', 'frequency.frequency_code'
          map 'kind', 'category_code'
        end
      end
    end
  end
end