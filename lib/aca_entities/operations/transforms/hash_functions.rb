# frozen_string_literal: true

# rubocop:disable Style/HashConversion, Style/OptionalArguments, Metrics/BlockNesting, Metrics/ModuleLength
require 'dry/transformer/all'
require "dry/inflector"
require 'deep_merge'

module AcaEntities
  module Operations
    module Transforms
      # This module provides services for hash transformations
      module HashFunctions
        extend Dry::Transformer::Registry
        import Dry::Transformer::Coercions
        import Dry::Transformer::HashTransformations
        import Dry::Transformer::ArrayTransformations

        module_function

        # map_value takes input hash, namespaces  and proc to transform value.
        # This method returns transformed hash.
        #
        # @param input The input hash
        # @param namespaces The namespaces is the array of nested keys
        # @param func is a proc
        #
        # @example
        #   map_value({:a => {:b => [{:person => {:age => "1969-03-01"}}]}}, [:a, :b, :person], -> v{v})
        #   # => {:a => {:b => [{:person=>{:age => 52}}]}}
        #
        # @return [Hash]
        def map_value(input, namespaces, func)
          source_hash = input[:source_hash] || input

          source_hash.to_h.tap do |hash|
            data_pair = if namespaces.empty?
                          hash
                        else
                          hash.dig(*namespaces) || hash
                        end

            transformed_pair = if func.is_a? Proc
                                 if input[:context]
                                   data_pair.update(data_pair) {|_k, _old_value| instance_exec(input[:context], &func)}
                                 else
                                   data_pair.update(data_pair) {|_k, old_value| instance_exec(old_value, &func)}
                                 end
                               else
                                 data_pair.transform_values!(&func)
                               end
            legacy_build_nested_hash({}, namespaces[0..-2].dup, transformed_pair)
          end
          input
        end

        # Add key to source hash using namespaced keys
        #
        # @param input The input hash
        # @param namespaced_keys The namespaced keys
        # @param value is a value
        #
        # @example
        #   add_key({:date_of_birth => nil}, [:a, :b, :person, :date_of_birth], "1969-03-01")
        #   # => {:a=>{:b=>[{:person=>{:date_of_birth=> "1969-03-01"}}]}}
        #
        # @return [Hash]
        def add_key(input, namespaced_keys, value)
          source_hash = input[:source_hash] || input

          value = nil if value == ''
          source_hash.to_h.tap do |hash|
            element = namespaced_keys.last
            output_hash = legacy_build_nested_hash({}, namespaced_keys[0..-2], Hash[element, value])
            hash[namespaced_keys[0]] = output_hash[namespaced_keys[0]]
            hash.delete(element) if namespaced_keys.size > 1
          end

          input
        end

        def add_namespace(source_hash, _source_namespace, destination_namespace)
          source_hash.to_h.tap do |hash|
            output_hash = legacy_build_nested_hash({}, destination_namespace[0..-2], hash)
            hash.delete(destination_namespace.last)
            hash.merge!(output_hash)
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
        #   boolean("YES")
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
        #   rename_nested_keys({"a" => {"b" => { "c" => {"d" => "123"}}, "f" => {"d" => "456"}}},  [{"d" => "e"}], ["a","b","c"])
        #   # => {"a" => {"b" => { "c" => {"e" => "123"}}, "f" => {"d" => "456"}}}
        #
        # @return [Hash]
        def rename_nested_keys(source_hash, mapping, namespaces = [])
          data_pair = if namespaces.empty?
                        source_hash
                      else
                        nested_hash(source_hash,   mapping.map(&:keys).flatten.first)
                      end

          mapping.first.each {|k, v| data_pair[v] = data_pair.delete(k) if data_pair.key?(k)}

          fns = []
          namespaces.each_with_index do |namespace, index|
            fns << "t(:wrap, :#{namespace}, [:#{namespaces[index + 1]}])"  if namespaces[index + 1]
          end
          # rubocop:disable Security/Eval
          fns = eval(fns.reverse.flatten.join('.>> '))
          # rubocop:enable Security/Eval
          fns ? fns.call([data_pair]).first : data_pair
        end

        def nested_hash(obj, key)
          if obj.respond_to?(:key?) && obj.key?(key)
            obj
          elsif obj.respond_to?(:each)
            result = nil
            obj.find { |*a| result = nested_hash(a.last, key) }
            result
          end
        end

        # Move keys to new namespace hash
        #
        # @param source_hash The input hash
        # @param source_namespaces accepts array of existing key namespace
        # @param destination_namespaces accepts array of new key namespace
        #
        # @example
        #   rewrap_keys({:foo => 'bar' }, [:boo, :foo], [:boo, :too])
        #   # => { :boo => { :too => 'bar' } }
        #
        # @return [Hash]
        def rewrap_keys(source_hash, source_namespaces, destination_namespaces = [])
          if source_namespaces.include?(:no_key)
            last_pair = get_last_pair(source_hash)
            source_hash.delete(source_namespaces.first)
            source_hash.merge!(Hash[destination_namespaces.last, last_pair.values.first])
          else
            source_hash.to_h.tap do |source_data|
              data_pair = source_data.dig(*source_namespaces[0..-2]) if source_namespaces.size > 1
              data_pair ||= source_data.dup

              # output = legacy_build_nested_hash({}, destination_namespaces[0..-2], Hash[destination_namespaces.last, data_pair.values.first])
              # binding.pry if data_pair.keys.first == :requestingCoverageIndicator
              if source_data.key?(source_namespaces.first)
                source_data.delete(source_namespaces.first)
              else
                source_data.delete(data_pair.keys.first)
              end
              output = Hash[destination_namespaces.last, data_pair.values.first]

              source_data.merge!(output)
            end
          end
        end

        def get_last_pair(data)
          case data
          when Array
            if data.first.is_a?(Array) || data.first.is_a?(Hash)
              get_last_pair(data.first)
            else
              data
            end
          when Hash
            value = data.values.first
            if value.is_a?(Hash) || (value.is_a?(Array) && value.first.is_a?(Hash))
              get_last_pair(value)
            else
              data
            end
          end
        end

        def add_context(source_hash, source_namespaces, destination_namespaces, func)
          func.call(destination_namespaces[0], source_hash.dig(*source_namespaces[0..-2]))
        end

        def build_nested_hash(record, values = [], data)
          namespace_values = values.map(&:keys).flatten
          if (current_namespace = namespace_values.first)
            init_value = (values[0][current_namespace] == :array ? [] : {})

            current_record = if record.is_a?(Array)
                               record.push(init_value)
                               record.last
                             else
                               record[current_namespace] ||= init_value
                               record[current_namespace]
                             end

            if namespace_values.empty?
              if record.is_a?(Array)
                current_record.is_a?(Array) ? current_record.push(data) : current_record.deep_merge!(data)
              else
                current_record.deep_merge!(data)
              end
            else
              build_nested_hash(current_record, values[1..-1], data)
            end
          elsif record.is_a?(Array)
            record.push(data)
          else
            record.deep_merge!(data)
          end

          record
        end

        # Convert data into a nested hash using values(namespaces) passed
        # Deep merge constructed hash into the record passed
        #
        # @param record Record hash
        # @param values Namespaces for the data
        # @param data Input hash that needed to be merged with the record
        #
        # @example
        #   build_nested_hash({ :family => { :family_members => { :person => { :gender => 'female' } } } },
        #   [:family, :family_members, :person], { dob: '1969-03-01'})
        #   # => { :family => { :family_members => { :person => { :gender => 'female', :dob => '1969-03-01'} } } }
        #
        # @return [Hash]
        def legacy_build_nested_hash(record, values = [], data)
          if (current_namespace = values.first)
            record[current_namespace] ||= {}

            if values.empty?
              record[current_namespace].deep_merge!(data)
            else
              record[current_namespace] = legacy_build_nested_hash(record[current_namespace], values[1..-1], data)
            end
          else
            record.deep_merge!(data)
          end

          record
        end

        # Converts nested hash into an array
        #
        # @param data Input hash
        #
        # @example
        #   nested_hash_to_array({:family=>{:family_members=>{:person=>{:gender=> "female"}}}})
        #   # => [:family, :family_members, :person, :gender]
        #
        # @return [Array]
        def nested_hash_to_array(data)
          return [] unless data
          data.reduce([]) do |keys, (key, value)|
            keys.push(key)
            keys.concat(nested_hash_to_array(value)) if value.is_a?(Hash)
          end
        end

        # Rename all keys upto nested hash
        #
        # @param source_hash The input hash
        # @param mapped_keys The key-rename mapping
        #
        # @example
        #   deep_rename_keys({"a" => {"b" => { "c" => {"d" => "123"}}, {"d" => "456"}}}, {"d" => "e"})
        #   # => {"a" => {"b" => { "c" => {"e" => "123"}}, {"e" => "456"}}}
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

        # Convert value to boolean string
        # @param value The input value

        # @example
        #   boolean_string(true)
        #   # =>  'Y'
        #
        # @return value
        def boolean_string(value)
          { true => 'Y', false => 'N' }[value]
        end
      end
    end
  end
end
# rubocop:enable Style/HashConversion, Style/OptionalArguments, Metrics/BlockNesting, Metrics/ModuleLength
