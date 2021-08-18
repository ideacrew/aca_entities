# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Cv
        # Transformers implementation for atp payloads
        class Phone < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          add_key 'start_on'
          add_key 'end_on'
          add_key 'extension'
          map 'contact.telephone_number.telephone.telephone_number_full_id', 'full_phone_number', memoize: true
          add_key 'area_code', value: ->(v) { v.resolve('full_phone_number').item.to_s[0..2]}
          add_key 'number', value: ->(v) { v.resolve('full_phone_number').item.to_s[3..9]}
          map 'is_primary_indicator', 'primary'
          map 'category_code', 'kind', function: ->(v) { v.to_s.downcase}
        end
      end
    end
  end
end