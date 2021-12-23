# frozen_string_literal: true

module AcaEntities
  module Operations
    module Mongoid
      MongoidPrivateKeys = %i[_id created_at updated_at].freeze

      # Resources for Dry-Structs to interact with Mongoid persistence
      module ModelAdapter
        module ClassMethods
          # @attr_reader [persistence_model_name] Mongoid Model class associated
          # with the Dry-Model Struct
          attr_reader :persistence_model_name
        end

        def persistence_klass
          Object.const_get(persistence_model_name)
        end

        # Persist the model instance to the backing store
        def create_model
          values = sanitize_attributes

          result = persistence_klass.send(:create, values)
          result ? Success(result) : Failure(result)
        end

        # Update the model instance in the backing store
        def update_model(record_id)
          values = sanitize_attributes

          instance = persistence_klass.send(:find, record_id)
          result = instance.update_attributes(values)

          result ? Success(result) : Failure(result)
        end

        # Transform a JSON-style nested hash into a flat hash moving the
        #   top-level key name to value of a designated key
        # @param [Hash] attr_hash the hash to transform
        # @param [Symbol, String] attribute_key the key on which to assign
        #   the top-level key
        # @return [Hash]
        # @example
        #   attr_hash = { :favorite_foods => { :fruit => 'apple', :vegetable => 'asparagus' } }
        #   to_flat_hash(attr_hash, :category)
        #   #=> { :fruit => 'apple', :vegetable => 'asparagus', :category => :favorite_foods }
        def to_flat_hash(attr_hash, attribute_key)
          hash_key = attr_hash.keys.first
          attr_hash[hash_key].merge(attribute_key => hash_key)
        end

        private

        # Strip any Mondoid-managed attributes from hash
        def sanitize_attributes
          to_h.reject { |k, _v| MongoidPrivateKeys.include?(k) }
        end
      end
    end
  end
end
