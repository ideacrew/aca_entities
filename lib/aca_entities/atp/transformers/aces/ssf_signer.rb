# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class SsfSigner < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'ref', 'role_reference.ref', function: ->(v) {"pe#{v}"}
          map 'first_name', 'signature.signature_name.given', memoize: true, visible: false
          map 'middle_name', 'signature.signature_name.middle', memoize: true, visible: false
          map 'last_name', 'signature.signature_name.sur', memoize: true, visible: false
          # map 'name_sfx', 'signature.signature_name.suffix'
          add_key 'signature.signature_name.full', value: lambda { |v|
            [v.resolve('signature.signature_name.given').item.to_s,
             v.resolve('signature.signature_name.middle').item.to_s,
             v.resolve('signature.signature_name.sur').item.to_s].join(' ')
          }
          add_key 'signature.signature_date.date', value: ->(_v) { Date.today } # default value
        end
      end
    end
  end
end