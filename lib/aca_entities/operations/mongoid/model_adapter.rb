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

        private

        # Strip any Mondoid-managed attributes from hash
        def sanitize_attributes
          to_h.reject { |k, _v| MongoidPrivateKeys.include?(k) }
        end
      end
    end
  end
end
