# frozen_string_literal: true

module AcaEntities
  module Operations
    module Mongoid
      # Resources for Mongoid to interact with Dry-Structs
      module EntityAdapter
        def to_entity_hash
          serializable_hash.merge('_id' => id.to_s).deep_symbolize_keys
        end
      end
    end
  end
end
