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
          options = args.first || {}
          if options.is_a?(Hash) && (options[:memoize] || options[:context] || options[:memoize_record])
            add_context((source_ns + [source_key]).join('.'), output_key, options)
          end
          transform_action = options[:action] if options[:action]

          # Returns only when visble is set to false
          return if options[:visible] == false

          # Creats an output_key with source_key's value
          mapping = Map.new((source_ns + [source_key]).join('.'),
                            (output_ns + [output_key.to_s]).join('.'),
                            nil,
                            transform_action || :rename_nested_keys,
                            proc: options[:function])

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
        def add_key(key, *args)
          raise 'arg1 should not be empty string or an integer' if key.empty? || key.is_a?(Integer)

          options = args.first || {}
          mapping = Map.new((source_ns + [key.split('.').last]).join('.'),
                            (output_ns + [key]).join('.'),
                            options[:value],
                            :add_key,
                            proc: options[:function])
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
          # raise 'expected arg1 not be empty string or an integer' if source_ns_key.empty? || source_ns_key.is_a?(Integer)
          # raise 'expected arg2 not be empty string or an integer' if output_namespace.empty? || output_namespace.is_a?(Integer)
          # raise 'expected arg3 not be empty' if args.empty?

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
            map.properties = args unless args.empty?
            map.context = @context
            @mappings[map.container_key] = map
          end

          source_keys = source_ns
          output_keys = output_namespace.to_s.split('.')
          if args.first && args.first[:type].to_s == 'array' && !source_ns.include?("*")
            source_keys << :no_key
            output_keys << :no_key
          end

          map = self.class.new(source_keys,
                               output_keys,
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
          
          # TODO: refactor map.context with below add_context to memoize the identifier with namespaces key identifier 
          # this helps to store namespaced identifier in attestation member and computed members                  
          add_context((source_ns + [source_namespace]).join('.'), output_namespace, args.first[:context]) if args.first && args.first[:context]
          
          # using below will not have the ability to store all the same identifiers in the different loops 
          # map.context = args.first[:context] if args.first && args.first[:context]
          map.instance_exec(&block)

          @mappings.merge!(map.mappings)
        end

        private

        # build context with namespaced identifier key
        # append_identifier arg to notify the context builder that there is a wild card, which should be appended to the key.
        # @api private
        def add_context(key, output_key, options)
          arg2 = output_key || key.split('.*').first
          map = Map.new(key,
                        arg2,
                        nil,
                        :add_context,
                        append_identifier: options[:append_identifier] || false,
                        proc: options[:function])
          map.properties = options
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
            serializer = MapSerializer.new('')
            serializer.map(source_key, output_key, *args)
            serializer.mappings.each do |_key, mapping|
              mapping_container.register(mapping.container_key, mapping) unless mapping_container.key?(mapping.source_key)
            end
          end

          # add_key takes key and value(can be a value or a proc).
          # This method returns object which has a function for hash transformation.
          #
          # @visibility public
          # @param [String] key
          # @param args describe as value with a proc or (integer/string) and function with a proc or a custom build funtion
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
          def add_key(key, *args)
            # value, and a function can be passed to the top level add key
            raise 'arg1 should not be empty string or an integer' if key.empty? || key.is_a?(Integer)

            options = args.first || {}
            mapping = Map.new(['add_key', key].join('.'),
                              key,
                              options[:value],
                              :add_key,
                              proc: options[:function])

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
          if namespace == "add_key"
            # When the namespace is a add_key, Regexp should match the namespace along with the other namespaced keys
            # "add_key.family.family_member.hbx_id"
            keys.select { |key| key.match?(/^#{Regexp.escape(namespace)}\.\w+/) }
          else
            keys.select { |key| key.match?(/^#{Regexp.escape(namespace)}\.\w+$/) }
          end
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
      # add append_identifier with default values false
      class Map
        attr_reader :source_key, :output_key, :value, :key_transforms, :result, :transproc, :proc, :type, :memoize_record, :append_identifier
        attr_accessor :context

        def initialize(source_key = nil, output_key = nil, value = nil, *key_transforms, append_identifier: false, proc: nil)
          @source_key = source_key
          @output_key = output_key
          @key_transforms = key_transforms
          @append_identifier = append_identifier
          @proc = proc

          if value.is_a?(Proc)
            @proc = value
          else
            @value = value
          end

          transform
        end

        def call(input)
          return input unless transproc
          transproc.call(input)
        end

        def t(*args)
          TransformFunctions[*args]
        end

        def transform
          source_elements = source_key.split('.')
          output_elements =  output_key ? output_key.split('.') : source_elements

          transform_procs = key_transforms.collect {|action| action_to_transproc(action, source_elements, output_elements)}.compact

          @transproc =
            if transform_procs.is_a?(String) || (transform_procs.flatten.is_a?(Array) && transform_procs.flatten.first.is_a?(String))
              if proc && !key_transforms.include?(:add_context)
                output = output_elements[0..-2]
                eval(transform_procs.flatten.join('.>> ')) >> t(:map_value, output.map(&:to_sym), proc)
              else
                eval(transform_procs.flatten.join('.>> '))
              end
            elsif proc && !key_transforms.include?(:add_context)
              output = output_elements[0..-2]
              transform_procs.first >> t(:map_value, output.map(&:to_sym), proc)
            else
              transform_procs.first
            end
        end

        def action_to_transproc(action, source_elements, output_elements)
          case action
          when :nest
            if source_elements[-1] == output_elements[-1]
              output_elements.size.times.collect do |i|
                offset = -1 * i
                "t(:nest, :#{output_elements[-2 + offset]}, [:#{output_elements[-1 + offset]}])" if output_elements[-2 + offset]
              end.compact
            end
          when :add_key
            "t(:add_key,  #{output_elements.map(&:to_sym)}, '#{value}')"
          when :rewrap_keys
            "t(:rewrap_keys, #{source_elements.map(&:to_sym)}, #{output_elements.map(&:to_sym)})"
          when :add_namespace
            "t(:add_namespace, #{source_elements.map(&:to_sym)}, #{output_elements.map(&:to_sym)})"
          when :rename_nested_keys
            source = source_key.split('.').last
            t(:"#{action}", ["#{source}": :"#{output_elements.last}"], output_elements.map(&:to_sym))
          when :add_context
            "t(:add_context, #{source_elements.map(&:to_sym)}, #{output_elements.map(&:to_sym)}, #{proc})" if proc
          else
            "t(:#{action}, #{source_key}: :#{output_elements.last})"
          end
        end

        def transproc_name
          if @transproc.respond_to?(:left)
            if transproc.left.is_a?(Dry::Transformer::Composite)
              ''
            else
              transproc.left&.name
            end
          else
            @transproc&.name
          end
        end

        def container_key
          if @key_transforms.include? :add_context
            "#{source_key}_context"
          else
            source_key
          end
        end

        def properties=(args)
          args = args.first unless args.is_a?(Hash)
          @type = args[:type]
          @memoize_record = args[:memoize_record] || false
        end
      end
    end
  end
end

# rubocop:enable Naming/MemoizedInstanceVariableName, Security/Eval, Metrics/CyclomaticComplexity, Lint/UselessMethodDefinition
