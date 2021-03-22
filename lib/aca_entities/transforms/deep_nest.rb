# frozen_string_literal: true

require 'dry/transformer/conditional'
require "dry/inflector"

module AcaEntities
  module Transforms
    # This module provides services for hash transformations
    module DeepNest
      module_function

      def deep_rename_keys(source_hash, mapped_keys)
        source_hash.each_with_object({}) do |(k, v), result|
          mapped_key = mapped_keys[k] || k
          result[mapped_key] = case v
                               when ::Hash
                                 deep_rename_keys(v, mapped_keys)
                               when ::Array
                                 v.map do |item|
                                   item.is_a?(Hash) ? deep_rename_keys(item, mapped_keys) : item
                                 end
                               else
                                 v
                               end
        end
      end

      def deep_accept_keys(source_hash, permitted_keys)
        source_hash.each_with_object({}) do |(key, value), output|
          next unless permitted_keys.include? key
          output[key] = case value
                        when ::Hash
                          deep_accept_keys(value, permitted_keys)
                        when ::Array
                          value.map do |item|
                            item.is_a?(Hash) ? deep_accept_keys(item, permitted_keys) : item
                          end
                        else
                          value
                        end
        end
      end

      def deep_map_keys(hash)
        inflector = Dry::Inflector.new
        hash.each_with_object({}) do |(key, value), output|
          output[inflector.underscore(key).to_sym] =
            case value
            when Hash
              deep_map_keys(value)
            when Array
              value.map do |item|
                item.is_a?(Hash) ? deep_map_keys(item) : item
              end
            else
              value
            end
        end
      end

    end
  end
end