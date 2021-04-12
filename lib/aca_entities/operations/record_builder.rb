# frozen_string_literal: true

module AcaEntities
  module Operations
    class RecordBuilder
      attr_reader :root, :data_set, :parent_ns, :output_ns, :namespace

      def initialize(root:, type:)
        @type = type
        @data_set = {}
        @root = root
      end

      def append(identifier, data, dig = true)
        data_pair = data.dig(*(output_ns).split('.').map(&:to_sym)) if dig
        @data_set[identifier] ||= {}
        @data_set[identifier].deep_merge!(data_pair || data)
        puts "----------********* #{@data_set.inspect} *************"
      end

      def output
        value = if @type == :array
          data_set.values
        else
          data_set
        end

        wrap((output_namespaces - parent_namespaces), value)
      end

      def output_namespace=(output_ns)
        @output_ns = output_ns
      end

      def namespace=(namespace)
        @namespace = namespace
      end

      def parent_namespace=(parent_namespace)
        @parent_ns = parent_namespace
      end

      def output_namespaces
        output_ns.split('.').map(&:to_sym)
      end

      def parent_namespaces
        return [] unless parent_ns
        parent_ns.split('.').map(&:to_sym)
      end

      def wrap(namespaces, data)
        return output if namespaces.empty?
        output = Hash[namespaces.pop.to_sym, data]
        output = wrap(namespaces, output) unless namespaces.empty?
        output
      end
    end
  end
end
