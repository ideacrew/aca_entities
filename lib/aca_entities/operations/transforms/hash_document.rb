# frozen_string_literal: true

# rubocop:disable Style/HashConversion, Style/OptionalBooleanParameter

module AcaEntities
  module Operations
    module Transforms
      # RecordBuilder for OJ stream and transform
      class HashDocument
        attr_reader :root, :data_set, :source_namespace, :output_namespace, :parent_namespace, :regex_key

        def initialize(root)
          # @type = type
          @data_set = {}
          @root = root
        end

        def append(data, dig = true)
          if root == :no_key
            value = data.dig(*parent_namespaces) unless parent_namespaces.empty?
            @data_set.merge!(value || data)
          else
            if output_namespaces.empty?
              @data_set.merge!(data)
            else
              @data_set[output_namespaces.last] ||= {}
              if data.keys.size == 1 && @data_set[output_namespaces.last].key?(data.keys.first)
                @data_set[output_namespaces.last].tap do |data_hash|
                  value = data_hash[data.keys.first]
                  if value.is_a?(Array)
                    value.push(*data.values.first)
                  else
                    value.merge!(data.values.first)
                  end
                  data_hash.merge!(Hash[data.keys.first, value])
                end
              else
                value = data.dig(*output_namespaces) unless output_namespaces.empty?
                @data_set[output_namespaces.last].merge!(value || data)
              end
            end
          end
        end

        def output
          # value = if @type == :array
          #           data_set.values
          #         else
          #           data_set
          #         end

          # wrap((output_namespaces - parent_namespaces), value)
          data_set
        end

        def source_namespace=(value)
          @source_namespace = value
        end

        def merge(data)
          # puts "------hash merge #{data}-------#{data_set}"
          append(data)

          # @data_set[output_namespaces.last] ||= {}
          # @data_set[output_namespaces.last].merge!(data)
        end

        def output_namespace=(value)
          @output_namespace = value
        end

        def parent_namespace=(value)
          @parent_namespace = value
        end

        def regex_key=(value)
          @regex_key = value
        end

        def output_namespaces
          output_namespace.map(&:to_sym)
        end

        def parent_namespaces
          return [] unless parent_namespace
          parent_namespace.map(&:to_sym)
        end

        def wrap(namespaces, data)
          return data if namespaces.empty?
          output = Hash[namespaces.pop.to_sym, data]
          output = wrap(namespaces, output) unless namespaces.empty?
          output
        end
      end
    end
  end
end
