# frozen_string_literal: true

# rubocop:disable Style/HashConversion

module AcaEntities
  module Operations
    module Transforms
      # RecordBuilder for OJ stream and transform
      class ArrayDocument
        attr_accessor :source_namespace, :output_namespace
        attr_reader :root, :data_set
        attr_writer :parent_namespace, :regex_key

        def initialize(root)
          # @type = type
          @data_set = []
          @root = root
        end

        def append(data)
          # data_pair = data.dig(*(output_ns).split('.').map(&:to_sym)) if dig
          # @data_set[identifier] ||= {}
          # @data_set[identifier].deep_merge!(data_pair || data)
          @data_set.push(data)
        end

        def output
          if output_namespaces.empty?
            data_set.first
          else
            Hash[output_namespaces.last, data_set]
          end
        end

        def merge(data)
          @data_set.push(data)
        end

        def output_namespaces
          output_namespace.map(&:to_sym)
        end

        def parent_namespaces
          return [] unless parent_namespace
          parent_namespace.split('.').map(&:to_sym)
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

# rubocop:enable Style/HashConversion