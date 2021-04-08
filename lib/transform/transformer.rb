# frozen_string_literal: true

# rubocop:disable Naming/MemoizedInstanceVariableName

require 'dry/transformer/all'
require "dry/inflector"
require 'json'

Inflector = Dry::Inflector.new

module Transform
  # collection of maps
  class MapSerializer

    attr_reader :source_ns, :output_ns, :mappings, :transform_action

    def initialize(source_namespace, output_namespace = nil, transform_action = nil, *_args)
      @source_ns = source_namespace.is_a?(Array) ? source_namespace.flatten : source_namespace.split('.')
      @output_ns = output_namespace.is_a?(Array) ? output_namespace.flatten : output_namespace.to_s.split('.')
      @transform_action = transform_action
      @mappings = {}
      construct_namespace_map
    end

    def construct_namespace_map
      return if transform_action == :rewrap_keys
      return unless source_ns.length == output_ns.length

      source_ns.each_with_index do |namespace, index|
        container_key = source_ns[0..index].join('.')
        next if @mappings.key?(container_key)
        @mappings[container_key] = if index == 0
                                     Transform::Map.new(namespace,
                                                        output_ns[index],
                                                        nil,
                                                        :rename_keys,
                                                        proc: nil)
                                   else
                                     Transform::Map.new(source_ns[0..index].join('.'),
                                                        output_ns[0..index].join('.'),
                                                        nil, :rename_nested_keys,
                                                        proc: nil)
                                   end
      end
    end

    def map(source_key = nil, output_key = nil, proc = nil)
      mapping = if source_key == ''
                  Transform::Map.new((source_ns + [output_key.to_s]).join('.'),
                                     (output_ns + [output_key.to_s]).join('.'),
                                     nil,
                                     :append_keys,
                                     proc: proc)
                else
                  Transform::Map.new((source_ns + [source_key]).join('.'),
                                     (output_ns + [output_key.to_s]).join('.'),
                                     nil,
                                     transform_action || :rename_nested_keys,
                                     proc: proc)
                end
      @mappings[mapping.container_key] = mapping
    end

    def add_key(key, value)
      mapping = Transform::Map.new((source_ns + [key]).join('.'),
                                   (output_ns + [key]).join('.'),
                                   value,
                                   :add_key,
                                   proc: nil)
      @mappings[mapping.container_key] = mapping
    end

    def rewrap(output_namespace = nil, *args, &block)
      unless args.empty?
        map = Transform::Map.new((source_ns).join('.'),
                                 output_namespace,
                                 nil,
                                 :rewrap_keys,
                                 proc: nil)
        map.properties = args
        @mappings[map.container_key] = map
      end

      map = self.class.new(source_ns,
                           output_namespace.to_s.split('.'),
                           :rewrap_keys,
                           args)
      map.instance_exec(&block)

      @mappings.merge!(map.mappings)
    end

    def namespace(source_namespace, output_namespace = nil, &block)
      # @mappings << Transform::Map.new(source_namespace, output_namespace, :rename_keys) if output_namespace.present?
      map = self.class.new(source_ns + source_namespace.split('.'),
                           output_ns + output_namespace.to_s.split('.'))
      map.instance_exec(&block)

      @mappings.merge!(map.mappings)
    end
  end

  # setup DSL functions
  module Transformer
    def self.included(base)
      base.extend ClassMethods
    end

    # setup DSL functions
    module ClassMethods
      # attr_reader :namespace

      def map(source_key = nil, output_key = nil, options = {})
        mapping = Transform::Map.new(source_key, output_key, options)
        # (mapping.namespace+[mapping.source_key]).map(&:to_s).join('.')
        mapping_container.register(mapping.source_key, mapping)
      end

      def add_key; end

      # FIX ME: deprecate map serializer
      def namespace(source_namespace, output_namespace = nil, &block)
        map = MapSerializer.new(source_namespace, output_namespace)
        # @namespace ||= []
        # @namespace.push(source_namespace)

        # yield if block_given?

        # @namespace.pop

        map.instance_exec(&block) if block_given?
        map.mappings.each do |_key, mapping|
          # key = (mapping.namespace+[mapping.source_key]).map(&:to_s).join('.')
          mapping_container.register(mapping.container_key, mapping) unless mapping_container.key?(mapping.source_key)
        end
      end

      def mapping_container
        @_maps_ ||= Dry::Container.new
      end
    end
  end

  class TransformFunctions
    extend Dry::Transformer::Registry

    import Dry::Transformer::HashTransformations
    import Dry::Transformer::ArrayTransformations
    import Dry::Transformer::Coercions
    import ::AcaEntities::Operations::HashFunctions
    import :camelize, from: Inflector, as: :camel_case
    import :underscore, from: Inflector, as: :underscore
  end

  # Creates transform proc
  class Map
    attr_reader :source_key, :output_key, :value, :key_transforms, :result, :transproc, :proc, :type

    def initialize(source_key = nil, output_key = nil, value = nil, *key_transforms, proc: nil)
      @source_key = source_key
      @output_key = output_key
      @key_transforms = key_transforms
      @value = value
      @proc = proc
      # @namespace = []
      transform
    end

    def call(input)
      transproc.call(input)
    end

    def t(*args)
      ::Transform::TransformFunctions[*args]
    end

    def transform
      source_elements = source_key.split('.')
      output_elements = output_key.split('.')

      # key_transforms.push(:nest).uniq! if elements.size > 1
      transform_procs = key_transforms.inject([]) do |procs, action|
        procs << case action
                 when :nest
                   output_elements.size.times.collect do |i|
                     offset = -1 * i
                     "t(:nest, :#{output_elements[-2 + offset]}, [:#{output_elements[-1 + offset]}])" if output_elements[-2 + offset]
                   end.compact
                 when :add_key
                   "t(:add_key,  #{output_elements.map(&:to_sym)}, '#{value}')"
                 when :append_keys
                   "t(:append_keys, #{source_elements.map(&:to_sym)}, #{output_elements.map(&:to_sym)})"
                 when :rewrap_keys
                   "t(:rewrap_keys, #{source_elements.map(&:to_sym)}, #{output_elements.map(&:to_sym)})"
                 when :rename_nested_keys
                   source = source_key.split('.').last
                   "t(:#{action}, [#{source}: :#{output_elements.last}], #{source_elements[0..-2].map(&:to_sym)})"
                 else
                   "t(:#{action}, #{source_key}: :#{output_elements.last})"
                 end
      end

      if proc
        output = output_elements[0..-2]
        transform_procs << "t(:map_value, #{output.map(&:to_sym)}, #{proc})"
      end

      @transproc = eval(transform_procs.flatten.join('.>> '))
    end

    def namespace_transform_required?
      return false if key_transforms.include?(:rewrap_keys) || key_transforms.include?(:append_keys)
      true
    end

    # Convert dob to age
    #
    # @param dob The input dob
    # @param on_date The age on the given date
    #
    # @example
    #   dob: Date.new(1980,1,1), on_date: Date.new(2021,1,1)
    #   # =>  41
    #
    # @return age
    def age_of(dob, on_date: Date.today)
      dob = t(:to_date)[dob]
      age = on_date.year - dob.to_date.year
      return age - 1 unless on_date.month > dob.month || (on_date.month == dob.month && on_date.day >= dob.day)
      age
    end

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

    # TODO
    def type_change(value)
      AcaEntities::Types::INCARCERATION_MAP[value.downcase.to_sym]
    end

    # def namespace=(value)
    #   @namespace = value
    # end

    def container_key
      source_key
    end

    def properties=(args)
      @type = args.first[:type]
    end

    # def process
    #   output_key || source_key
    #   # collect_namespace(a_hash, *namespace)
    #   # # @result  = send(:"#{action}_keys", a_hash.first, {from.to_sym => to.to_sym})
    #   # @result = t(:deep_rename_keys).call(a_hash, {from.to_sym => to.to_sym})
    #   #
    #   #
    #   # result = t(:deep_map_keys).call(a_hash) if action == :underscore
    #   # result = t(:"#{action}_keys").call(a_hash, from) if action == :deep_accept
    #   # result
    #   # # @result = t(:"#{action}_keys").call(a_hash,{from.to_sym => to.to_sym}) if action == :deep_rename
    # end

    # def t(*args)
    #   Transform::Transformer[*args]
    # end
  end
end

# rubocop:enable Naming/MemoizedInstanceVariableName
