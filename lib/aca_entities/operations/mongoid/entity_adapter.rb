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

        # Transform a flat hash into a JSON-style nested hash using the value
        #   of a designated key as the top-level key
        # Returns original hash if the key isn't found
        # @param [Hash] attr_hash the hash to transform
        # @param [Symbol, String] attribute_key the key thats value will become
        #   the top-level key
        # @return [Hash]
        # @example
        #   attr_hash = { :fruit => 'apple', :vegetable => 'asparagus', :category => :favorite_foods }
        #   to_map_hash(attr_hash, :category)
        #   #=> { :favorite_foods => { :fruit => 'apple', :vegetable => 'asparagus' } }
        def to_map_hash(attr_hash, attribute_key)
          return attr_hash unless attr_hash.keys.include? attribute_key

          hash_key = attr_hash[attribute_key]
          { hash_key => attr_hash.reject { |k, _v| k == attribute_key } }
        end
      end
    end
  end
end
