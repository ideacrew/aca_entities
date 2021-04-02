# rubocop:disable all

# frozen_string_literal: true

require 'dry/transformer/all'
require "dry/inflector"
require 'json'

Inflector = Dry::Inflector.new

module Transform
  # collection of maps
  class EntityMapper

    attr_accessor :mappings

    def initialize(namespace)
      @namespace = [namespace]
      @mappings = []
    end

    def map(source_key = nil, output_key = nil, transform: [])
      mapping = Transform::Mapper.new(source_key, output_key, transform)
      mapping.namespace = @namespace.flatten
      @mappings.push(mapping)
    end

    def group(associations, &block)
      map = self.class.new(@namespace + [associations])
      map.instance_exec(&block)
      @mappings += map.mappings
    end
  end

  module Transformer
    extend Dry::Transformer::Registry
    import Dry::Transformer::HashTransformations
    import Dry::Transformer::ArrayTransformations
    import ::AcaEntities::Operations::HashFunctions

    import :camelize, from: Inflector, as: :camel_case
    import :underscore, from: Inflector, as: :underscore

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def map(source_key = nil, output_key = nil, *actions)
        mapping = Transform::Mapper.new(source_key, output_key, actions.flatten)
        key = (mapping.namespace+[mapping.source_key]).map(&:to_s).join('.')
        mapping_container.register(key, mapping)
      end

      def group(associations, &block)
        map = EntityMapper.new(associations)
        map.instance_exec(&block)
        map.mappings.each do |mapping|
          key = (mapping.namespace+[mapping.source_key]).map(&:to_s).join('.')
          mapping_container.register(key, mapping)
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
    import ::AcaEntities::Operations::HashFunctions
  end

  class Mapper
    attr_reader :source_key, :output_key, :actions, :result, :transproc, :namespace

    def initialize(source_key = nil, output_key = nil, actions, &block)
      @source_key = source_key
      @output_key = output_key
      @actions = actions
      @namespace = []
      transform
    end

    def t(*args)
      ::Transform::TransformFunctions[*args]
    end

    def transform
      elements = output_key.split('.')
      # actions.push(:nest).uniq! if elements.size > 1

      transform_procs = actions.inject([]) do |procs, action|
        procs << if action == :nest
          elements.size.times.collect do |i|
            offset = -1 * i
            "t(:nest, :#{elements[-2 + offset]}, [:#{elements[-1 + offset]}])" if elements[-2 + offset]
          end.compact
        elsif action == :rewrap_keys
          "t(:rewrap_keys, #{source_key.split('.').map(&:to_sym)}, #{elements.map(&:to_sym)})"
        elsif action == :rename_nested_keys
          source = source_key.split('.').last
          "t(:#{action}, [#{source}: :#{elements.last}], #{elements[0..-2].map(&:to_sym)})"
        else
          "t(:#{action}, #{source_key}: :#{elements.last})"
        end
      end
      # binding.pry
      # binding.pry
      @transproc = eval(transform_procs.flatten.join('.>> '))
    end

    def namespace=(value)
      @namespace = value
    end

    def call(input)
      transproc.call(input)
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

# rubocop:enable all

