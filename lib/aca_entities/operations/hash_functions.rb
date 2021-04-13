# frozen_string_literal: true

# rubocop:disable Style/HashConversion, Style/OptionalArguments
require 'dry/transformer/all'
require "dry/inflector"
require 'deep_merge'

module AcaEntities
  module Operations
    # This module provides services for hash transformations
    module HashFunctions
      extend Dry::Transformer::Registry
      import Dry::Transformer::Coercions

      module_function

      # Transform a value using namespace and a proc
      #
      # @param input The input hash
      # @param namespaces The namespaces is the array of nested keys
      # @param func is a proc
      #
      # @example
      #   input: {:family=>{:family_members=>[{:person=>{:value=> "1969-03-01"}}]}}
      #   namespaces: [:family, :family_members, :person]
      #   func: proc
      #
      #   # => {:family=>{:family_members=>[{:person=>{:value=> 52}}]}}
      #
      # @return [Hash]
      def map_value(input, namespaces, func)
        source_hash = if input[:source_hash]
                        input[:source_hash]
                      else
                        input
                      end

        source_hash.to_h.tap do |hash|
          final_pair = hash.dig(*namespaces)

          transformed_pair = if func.is_a? Proc
            if input[:context]
              final_pair.update(final_pair) {|_k, old_value| instance_exec(input[:context], &func)}
            else
              final_pair.update(final_pair) {|_k, old_value| instance_exec(old_value, &func)}
            end
          else
            final_pair.transform_values!(&func)
          end
          initialize_or_assign({}, namespaces[0..-2].dup, transformed_pair)
        end
        input
      end

      # Add key using namespaced_key
      #
      # @param input The input hash
      # @param namespaced_keys The namespaced keys
      # @param value is a value
      #
      # @example
      #   input: {:date_of_birth => nil}
      #   namespaced_keys: [:family, :family_members, :person, :date_of_birth]
      #   value: "1969-03-01"
      #
      #   # => {:family=>{:family_members=>[{:person=>{:date_of_birth=> "1969-03-01"}}]}}
      #
      # @return [Hash]
      def add_key(input, namespaced_keys, value)
        source_hash = if input[:source_hash]
                        input[:source_hash]
                      else
                        input
                      end

        value = nil if value == ''
        source_hash.to_h.tap do |hash|
          element = namespaced_keys.last
          output_hash = initialize_or_assign({}, namespaced_keys[0..-2], Hash[element, value])
          hash[namespaced_keys[0]] = output_hash[namespaced_keys[0]]
          hash.delete(element)
        end

        input
      end

      def add_namespace(source_hash, source_namespace, destination_namespace)
        source_hash.to_h.tap do |hash|
          output_hash = initialize_or_assign({}, destination_namespace[0..-2], hash)
          hash.delete(destination_namespace.last)
          hash.merge!(output_hash)
          binding.pry
        end
      end

      # # Convert dob to age
      # #
      # # @param dob The input dob
      # # @param on_date The age on the given date
      # #
      # # @example
      # #   dob: Date.new(1980,1,1), on_date: Date.new(2021,1,1)
      # #   # =>  41
      # #
      # # @return age
      # def age_of(dob, on_date: Date.today)
      #   dob = t(:to_date)[dob]
      #   age = on_date.year - dob.to_date.year
      #   return age - 1 unless on_date.month > dob.month || (on_date.month == dob.month && on_date.day >= dob.day)
      #   age
      # end

      # Convert value to boolean
      #
      # @param value The input value
      #
      # @example
      #   value: "YES"
      #   # =>  true
      #
      # @return value
      def boolean(value)
        t(:to_boolean)[value.to_s.downcase]
      end

      # Rename particular keys using namespace
      #
      # @param source_hash The input hash
      # @param mapping The key-rename mapping
      #
      # @example
      #   source_hash: {"a" => {"b" => { "c" => {"d" => "123"}}, "f" => {"d" => "456"}}}, mapping: [{"d" => "e"}], namespaces: ["a","b","c"]
      #   # => {"a" => {"b" => { "c" => {"e" => "123"}}, "f" => {"d" => "456"}}}
      #
      # @return [Hash]
      def rename_nested_keys(source_hash, mapping, namespaces = [])
        puts "------>>>> #{namespaces} ---- #{source_hash}"
        source_hash.to_h.tap do |hash|
          final_pair = hash.dig(*namespaces)
          mapping.first.each {|k, v| final_pair[v] = final_pair.delete(k) if final_pair.key?(k)}
        end
      end

      def rewrap_keys(source_hash, source_namespaces, destination_namespaces = [])
        puts "------>>>> unwrap #{source_hash} -- #{source_namespaces} ---- #{destination_namespaces}"
        source_hash.to_h.tap do |source_data|

          # value = source_data.dig(*source_namespaces)
          element = destination_namespaces.last
          output = initialize_or_assign({}, destination_namespaces[0..-2], Hash[element, source_data[source_namespaces.last]])
          # output = initialize_or_assign({}, destination_namespaces[0..-2], Hash[element, value])

          source_data.delete(source_namespaces.last)
          # source_data.delete(source_namespaces.first)
          source_data[destination_namespaces[0]] = output[destination_namespaces[0]]
        end
      end

      def add_context(source_hash, source_namespaces, destination_namespaces, func)
        func.call(destination_namespaces[0], source_hash.dig(*source_namespaces[0..-2]))
      end

      def initialize_or_assign(local_record, values = [], data)
        if (current_namespace = values.shift)
          local_record[current_namespace] ||= {}

          if values.empty?
            local_record[current_namespace].deep_merge!(data)
          else
            local_record[current_namespace] = initialize_or_assign(local_record[current_namespace], values, data)
          end
        else
          local_record.deep_merge!(data)
        end

        local_record
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
          output[inflector.underscore(key).to_sym] = case value
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
# rubocop:enable Style/HashConversion, Style/OptionalArguments
