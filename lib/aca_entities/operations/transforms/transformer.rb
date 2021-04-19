# frozen_string_literal: true

# rubocop:disable Naming/MemoizedInstanceVariableName, Security/Eval, Metrics/CyclomaticComplexity, Lint/UselessMethodDefinition

require 'dry/transformer/all'
require "dry/inflector"
require 'json'

Inflector = Dry::Inflector.new
module AcaEntities
  module Operations
    module Transforms
      # collection of maps
      class MapSerializer

        attr_reader :source_ns, :output_ns, :mappings, :transform_action
        attr_writer :context

        def initialize(source_namespace, output_namespace = nil, transform_action = nil, *_args)
          @source_ns = source_namespace.is_a?(Array) ? source_namespace.flatten : source_namespace.split('.')
          @output_ns = output_namespace.is_a?(Array) ? output_namespace.flatten : output_namespace.to_s.split('.')
          @transform_action = transform_action
          @mappings = {}
          construct_namespace_map
        end

        # map takes source_key, output_key and *args to build transform object.
        # This method returns object which has a function for hash transformation.
        #
        # @visibility public
        # @param source_key [#to_s] The input is a single key or a namespaced key
        # @param output_key [#to_s] The output is a single key or a namespaced key
        # @param args
        #
        # @example
        #   map "firstname", "first_name"
        #   # => Object
        #
        # @example
        #   map "a.b.firstname", "c.d.first_name"
        #   # => Object
        #
        # @example
        #   map "a.b.dob", "c.d.age", -> v {age_on(v)}
        #   # => Object
        #
        # @return [Object]
        #
        # @api public
        def map(source_key, output_key = nil, *args)
          options = args.first

          if options
            if options.is_a?(Hash) && options[:memoize]
              add_context((source_ns + [source_key]).join('.'), output_key, options[:function])
              return
            else
              proc = options
            end
          end

          mapping = Map.new((source_ns + [source_key]).join('.'),
                            (output_ns + [output_key.to_s]).join('.'),
                            nil,
                            transform_action || :rename_nested_keys,
                            proc: proc)
          @mappings[mapping.container_key] = mapping
        end

        # add_key takes key and value(can be a value or a proc).
        # This method returns object which has a function for hash transformation.
        #
        # @visibility public
        # @param [String] key
        # @param value describe a proc or a value(integer/string)
        #
        # @example
        #   add_key "fname"
        #   # => Object
        #
        # @example
        #   add_key "fname", ->(v) { v.resolve(:members).name } # proc should be derived based on namespace method context
        #   # => Object
        #
        # @return [Object]
        #
        # @api public
        def add_key(key, value = nil)
          raise 'arg1 should not be empty string or an integer' if key.empty? || key.is_a?(Integer)

          mapping = Map.new((source_ns + [key]).join('.'),
                            (output_ns + [key]).join('.'),
                            value,
                            :add_key,
                            proc: nil)
          @mappings[mapping.container_key] = mapping
        end

        # add_namespace takes source_ns_key, output_namespace, *args(for additional operations) and a block.
        # This generates new hash with new key-value pair.
        #
        # @visibility public
        #   @param source_ns_key [#to_s] The source_ns_key is a single key
        #   @param output_namespace [#to_s] The output_namespace is a single key or a namespaced key
        #   @param args [Symbol] describe hash param with key context:
        #   @param [Object] block
        #
        # @example
        #   add_namespace "IDs", "a.b.IDs", type: :array do end
        #   # => Hash with namespaced key and value as object
        #
        # @return [Hash]
        #
        # @api public
        def add_namespace(source_ns_key, output_namespace, *args, &block)
          raise 'expected arg1 not be empty string or an integer' if source_ns_key.empty? || source_ns_key.is_a?(Integer)
          raise 'expected arg2 not be empty string or an integer' if output_namespace.empty? || output_namespace.is_a?(Integer)
          raise 'expected arg3 not be empty' if args.empty?

          map = Map.new((source_ns + [source_ns_key]).join('.'),
                        output_namespace,
                        nil,
                        :add_namespace)
          map.properties = args
          @mappings[map.container_key] = map

          map = self.class.new((source_ns + [source_ns_key]),
                               output_namespace.to_s.split('.'),
                               :add_namespace,
                               args)

          map.instance_exec(&block) if block_given?
          @mappings.merge!(map.mappings)
        end

        # Rewrap takes output_namespace, *args(for additional operations) and a block.
        # This generated a new hash with existing or new key-value pairs
        #
        # @visibility public
        #   @param output_namespace [#to_s] The output_namespace is a single key or a namespaced key
        #   @param args [Symbol] describe hash param with key context:
        #   @param [Object] block
        #
        # @example
        #   rewrap "a" do end
        #   # => Hash with namespaced key and value as object
        #
        # @example
        #   rewrap "a",  type: :array do end
        #   # => Hash with namespaced key and value as object
        #
        # @return (see #add_namespace)
        #
        # @api public
        def rewrap(output_namespace = nil, *args, &block)
          raise 'no block given' unless block_given?

          unless args.empty?
            map = Map.new((source_ns).join('.'),
                          output_namespace,
                          nil,
                          :rewrap_keys,
                          proc: nil)
            map.properties = args
            map.context = @context
            @mappings[map.container_key] = map
          end

          map = self.class.new(source_ns,
                               output_namespace.to_s.split('.'),
                               :rewrap_keys,
                               args)
          map.instance_exec(&block)

          @mappings.merge!(map.mappings)
        end

        # Namespace takes source_namespace, output_namespace, *args(for additional operations) and a block
        # This method returns hash with namespaced key and value as object(that has transform functions).
        #
        # @visibility public
        #   @param source_namespace [#to_s] The source_namespace is a single key or a namespaced key
        #   @param output_namespace [#to_s] The output_namespace is a single key or a namespaced key
        #   @param args [Symbol] describe hash param with key context:
        #   @param [Object] block
        #
        # @example
        #   namespace "a" do end
        #   # => Hash with namespaced key and value as object
        #
        # @example
        #   namespace "a", nil, context: { name: 'members' } do end
        #   # => Hash with namespaced key and value as object
        #
        # @return (see #rewrap)
        #
        # @api public
        def namespace(source_namespace, output_namespace = nil, *args, &block)
          # raise 'expected arg1 not be empty string or an integer' if source_namespace.empty? || source_namespace.is_a?(Integer)
          raise 'no block given' unless block_given?

          # @mappings << Map.new(source_namespace, output_namespace, :rename_keys) if output_namespace.present?
          map = self.class.new(source_ns + source_namespace.split('.'),
                               output_ns + output_namespace.to_s.split('.'))
          map.context = args.first[:context] if args.first && args.first[:context]
          map.instance_exec(&block)

          @mappings.merge!(map.mappings)
        end

        private

        # @api private
        def add_context(key, output_key, proc = nil)
          map = Map.new(key,
                        output_key,
                        nil,
                        :add_context,
                        proc: proc)
          @mappings[map.container_key] = map
        end

        # @api private
        def construct_namespace_map
          return if [:rewrap_keys, :add_namespace].include?(transform_action)
          return unless source_ns.length == output_ns.length

          source_ns.each_with_index do |namespace, index|
            container_key = source_ns[0..index].join('.')
            next if @mappings.key?(container_key)
            @mappings[container_key] = if index == 0
                                         Map.new(namespace,
                                                 output_ns[index],
                                                 nil,
                                                 :rename_keys,
                                                 proc: nil)
                                       else
                                         Map.new(source_ns[0..index].join('.'),
                                                 output_ns[0..index].join('.'),
                                                 nil, :rename_nested_keys,
                                                 proc: nil)
                                       end
          end
        end
      end

      # setup DSL functions
      module Transformer
        def self.included(base)
          base.extend ClassMethods
        end

        # setup DSL functions
        module ClassMethods

          # map takes source_key, output_key and *args to build transform object.
          # This method returns object which has a function for hash transformation.
          #
          # @visibility public
          # @param source_key [#to_s] The input is a single key or a namespaced key
          # @param output_key [#to_s] The output is a single key or a namespaced key
          # @param args
          #
          # @example
          #   map "firstname", "first_name"
          #   # => Object
          #
          # @example
          #   map "a.b.firstname", "c.d.first_name"
          #   # => Object
          #
          # @example
          #   map "a.b.dob", "c.d.age", -> v {age_on(v)}
          #   # => Object
          #
          # @return [Object]
          #
          # @api public
          def map(source_key = nil, output_key = nil, *args)
            mapping = Map.new(source_key, output_key, nil, :rename_nested_keys, proc: args.first)
            mapping_container.register(mapping.container_key, mapping)
          end

          # add_key takes key and value(can be a value or a proc).
          # This method returns object which has a function for hash transformation.
          #
          # @visibility public
          # @param [String] key
          # @param value describe a proc or a value(integer/string)
          #
          # @example
          #   add_key "fname"
          #   # => Object
          #
          # @example
          #   add_key "fname", ->(v) { v.resolve(:members).name } # proc should be derived based on namespace method context
          #   # => Object
          #
          # @return [Object]
          #
          # @api public
          def add_key(key, value = nil)
            raise 'arg1 should not be empty string or an integer' if key.empty? || key.is_a?(Integer)

            mapping = Map.new(['add_key', key].join('.'),
                              key,
                              value,
                              :add_key,
                              proc: nil)

            mapping_container.register(mapping.container_key, mapping)
          end

          # FIX ME: deprecate map serializer
          # Namespace takes source_namespace, output_namespace, *args(for additional operations) and a block
          # This method returns hash with namespaced key and value as object(that has transform functions).
          #
          # @visibility public
          #   @param source_namespace [#to_s] The source_namespace is a single key or a namespaced key
          #   @param output_namespace [#to_s] The output_namespace is a single key or a namespaced key
          #   @param [Object] block
          #
          # @example
          #   namespace "a" do end
          #   # => Hash with namespaced key and value as object
          #
          # @example
          #   namespace "a" do end
          #     namespace "a", nil, context: { name: 'members' } do end
          #   end
          #   # => Hash with namespaced key and value as object
          #
          # @return (see #rewrap)
          #
          # @api public
          def namespace(source_namespace, output_namespace = nil, &block)
            # raise 'expected arg1 not be empty string or an integer' if source_namespace.empty? || source_namespace.is_a?(Integer)
            raise 'no block given' unless block_given?

            map = MapSerializer.new(source_namespace, output_namespace)
            map.instance_exec(&block) if block_given?
            map.mappings.each do |_key, mapping|
              mapping_container.register(mapping.container_key, mapping) unless mapping_container.key?(mapping.source_key)
            end
          end

          def mapping_container
            @_maps_ ||= TransformContainer.new
          end
        end
      end

      # container for DSL
      class TransformContainer < Dry::Container
        # attr_reader :keys_by_namespace

        def initialize
          # @keys_by_namespace = {}
          super
        end

        def keys_under_namespace(namespace)
          # return @keys_by_namespace[namespace] if @keys_by_namespace[namespace]
          # @keys_by_namespace[namespace] =
          keys.select { |key| key.match?(/^#{Regexp.escape(namespace)}\.\w+$/) }
        end
      end

      class TransformFunctions
        extend Dry::Transformer::Registry

        import Dry::Transformer::HashTransformations
        import Dry::Transformer::ArrayTransformations
        import Dry::Transformer::Coercions
        import HashFunctions
        import :camelize, from: Inflector, as: :camel_case
        import :underscore, from: Inflector, as: :underscore
      end

      # Creates transform proc
      class Map
        attr_reader :source_key, :output_key, :value, :key_transforms, :result, :transproc, :proc, :type
        attr_accessor :context

        def initialize(source_key = nil, output_key = nil, value = nil, *key_transforms, proc: nil)
          @source_key = source_key
          @output_key = output_key
          @key_transforms = key_transforms
          @proc = proc

          if value.is_a?(Proc)
            @proc = value
          else
            @value = value
          end

          transform
        end

        def call(input)
          transproc.call(input)
        end

        def t(*args)
          TransformFunctions[*args]
        end

        def transform
          source_elements = source_key.split('.')
          output_elements =  output_key ? output_key.split('.') : source_elements

          transform_procs = key_transforms.collect {|action| action_to_transproc(action, source_elements, output_elements)}

          @transproc = if proc && !key_transforms.include?(:add_context)
                         output = output_elements[0..-2]
                         eval(transform_procs.flatten.join('.>> ')) >> t(:map_value, output.map(&:to_sym), proc)
                       else
                         eval(transform_procs.flatten.join('.>> '))
                       end
        end

        def action_to_transproc(action, source_elements, output_elements)
          case action
          when :nest
            output_elements.size.times.collect do |i|
              offset = -1 * i
              "t(:nest, :#{output_elements[-2 + offset]}, [:#{output_elements[-1 + offset]}])" if output_elements[-2 + offset]
            end.compact
          when :add_key
            "t(:add_key,  #{output_elements.map(&:to_sym)}, '#{value}')"
          when :rewrap_keys
            "t(:rewrap_keys, #{source_elements.map(&:to_sym)}, #{output_elements.map(&:to_sym)})"
          when :add_namespace
            "t(:add_namespace, #{source_elements.map(&:to_sym)}, #{output_elements.map(&:to_sym)})"
          when :rename_nested_keys
            source = source_key.split('.').last
            "t(:#{action}, [#{source}: :#{output_elements.last}], #{source_elements[0..-2].map(&:to_sym)})"
          when :add_context
            "t(:add_context, #{source_elements.map(&:to_sym)}, #{output_elements.map(&:to_sym)}, #{proc})"
          else
            "t(:#{action}, #{source_key}: :#{output_elements.last})"
          end
        end

        def transproc_name
          if @transproc.respond_to?(:left)
            transproc.left.name
          else
            @transproc.name
          end
        end

        def container_key
          source_key
        end

        def properties=(args)
          @type = args.first[:type]
        end
      end
    end
  end
end

# rubocop:enable Naming/MemoizedInstanceVariableName, Security/Eval, Metrics/CyclomaticComplexity, Lint/UselessMethodDefinition
