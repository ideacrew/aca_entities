# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class SsfSigner < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map 'ref', 'role_reference.ref'
          map 'first_name', 'signature.signature_name.given'
          map 'middle_name', 'signature.signature_name.middle'
          map 'last_name', 'signature.signature_name.sur'
          map 'name_sfx', 'signature.signature_name.suffix'
          map 'full', 'signature.signature_name.full_name'
          add_key 'signature.signature_date'
        end
      end
    end
  end
end