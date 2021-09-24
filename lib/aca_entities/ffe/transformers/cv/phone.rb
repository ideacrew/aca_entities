# frozen_string_literal: true

module AcaEntities
  module Ffe
    module Transformers
      module Cv
        # Transform person Phone
        class Phone < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'number', 'full_phone_number', memoize: true, visible: true
          map 'ext', 'extension'
          map 'type', 'kind', function: ->(v) {v.to_s.downcase}
          add_key 'area_code', function: ->(v) {v.resolve('full_phone_number').item[0..2]}
          add_key 'number', function: ->(v) {v.resolve('full_phone_number').item[3..9]}
          map 'primary', 'primary'
          add_key 'start_on'
          add_key 'end_on'

        end
      end
    end
  end
end