# frozen_string_literal: true

module AcaEntities
  module Operations
    module Mongoid
      # Resources for Mongoid to interact with Dry-Structs
      module EntityAdapter
        # Transform a Mongoid instance's nested hash into a form easily processed
        # by Dry-Validation and Dry-Struct objects
        # @return [Hash]
        def to_entity_hash
          serializable_hash.merge('_id' => id.to_s).deep_symbolize_keys
        end

        # Transform a Mongoid record hash into a JSON-style nested map hash using the value
        #   of a designated field as the top-level key
        # @param [Symbol, String] attribute_key the key thats value will become
        #   the top-level key
        # @return [Hash]
        # @example
        #   attr_hash = { :fruit => 'apple', :vegetable => 'asparagus', :category => :favorite_foods }
        #   attr_hash.to_entity_map_hash(:category)
        #   #=> { :favorite_foods => { :fruit => 'apple', :vegetable => 'asparagus' } }
        # rubocop:disable Style/IfUnlessModifier
        def to_entity_map_hash(attribute_key)
          unless has_attribute?(attribute_key)
            raise(ArgumentError, "#{attribute_key} attribute key not found")
          end

          hash_key = attributes[attribute_key]
          { hash_key => attributes.reject { |k, _v| k == attribute_key } }
        end
        # rubocop:enable Style/IfUnlessModifier
      end
    end
  end
end
