# frozen_string_literal: true

require 'dry/transformer/conditional'
require "dry/inflector"

module AcaEntities
  module Operations
    # This module provides services for hash transformations
    module HashFunctions
      module_function

      # Rename particular keys using namespace
      #
      # @param source_hash The input hash
      # @param mapping The key-rename mapping
      #
      # @example
      #   source_hash: {"a" => {"b" => { "c" => {"d" => "123"}}, {"d" => "456"}}, mapping: {"d" => "e"}, namespaces: [:a,:b,:c]
      #   # =>   {"a" => {"b" => { "c" => {"e" => "123"}}, {"d" => "456"}}
      #
      # @return [Hash]
      def rename_nested_keys(source_hash, mapping, namespaces = [])
        source_hash.to_h.tap do |hash|
          final_pair = hash.dig(*namespaces)
          mapping.first.each {|k, v| final_pair[v] = final_pair.delete(k) if final_pair.key?(k)}
        end
      end

      # Rename all keys upto nested hash
      #
      # @param source_hash The input hash
      # @param mapped_keys The key-rename mapping
      #
      # @example
      #   source_hash: {"a" => {"b" => { "c" => {"d" => "123"}}, {"d" => "456"}}, mapping: {"d" => "e"}
      #   # =>  {"a" => {"b" => { "c" => {"e" => "123"}}, {"e" => "456"}}
      #
      # @return [Hash]
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

      # TODO
      def collect_namespace(source_hash, *keys)
        keys = keys.dup
        next_key = keys.shift

        return [] unless source_hash.key? next_key

        next_val = source_hash[next_key]

        return [next_val] if keys.empty?

        case next_val
        when Hash
          next_val.collect_namespace(*keys)
        when Array
          next_val.each_with_object([]) do |v, result|
            inner = v.collect_namespace(*keys)
            result.concat inner
          end
        else
          []
        end
      end
    end
  end
end