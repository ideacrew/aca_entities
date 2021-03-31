# rubocop:disable all

# frozen_string_literal: true

require 'dry/transformer/all'
require 'aca_entities/transforms/deep_nest'
require "dry/inflector"
require 'json'

Inflector = Dry::Inflector.new

module Transform
  # collection of maps
  class EntityMapper

    attr_accessor :mappings

    def initialize(namespace)
      @namespace = namespace
      @mappings = []
    end

    def map(source_key = nil, output_key = nil, transform: {})
      @mappings << Modifier::Mapper.new(source_key, output_key, @namespace, transform)
    end

    def group(associations, &block)
      map = self.class.new(@namespace + associations)
      map.instance_exec(&block)
      @mappings += map.mappings
    end
  end

  module Transformer
    extend Dry::Transformer::Registry
    import Dry::Transformer::HashTransformations
    import Dry::Transformer::ArrayTransformations
    import AcaEntities::Transforms::DeepNest
    import :camelize, from: Inflector, as: :camel_case
    import :underscore, from: Inflector, as: :underscore

    def self.included(base_class)
      base_class.extend ClassMethods
      base_class.include InstanceMethods
    end

    module ClassMethods
      def map(source_key = nil, output_key = nil, namespace: nil, transform: {})
        mapping = Modifier::Mapper.new(source_key, output_key, namespace, transform)
        key = (mapping.namespace+[mapping.source_key]).flatten.map(&:to_s).join('.')
        mapping_container.register(key, mapping)
      end

      def group(associations, &block)
        map = EntityMapper.new(associations)
        map.instance_exec(&block)
        map.mappings.each do |mapping|
          key = (mapping.namespace+[mapping.source_key]).flatten.map(&:to_s).join('.')
          mapping_container.register(key, mapping)
        end
      end

      def mapping_container
        @_maps_ ||= Dry::Container.new
      end
    end

    module InstanceMethods
      def call(input)
        # self.class.items.reduce(input.first) do |result, item|
        #   result = item.process(result)
        #   result
        # end
      end
    end

    class Mapper
      attr_reader :source_key, :output_key, :result, :action, :namespace

      def initialize(source_key = nil, output_key = nil, namespace, transform, &block)
        @source_key= source_key
        @output_key = output_key
        @namespace = namespace
        @action = transform.empty? ? :deep_rename : transform.fetch(:using, nil)
      end

      def process
        # collect_namespace(a_hash, *namespace)
        # # @result  = send(:"#{action}_keys", a_hash.first, {from.to_sym => to.to_sym})
        # @result = t(:deep_rename_keys).call(a_hash, {from.to_sym => to.to_sym})
        #
        #
        # result = t(:deep_map_keys).call(a_hash) if action == :underscore
        # result = t(:"#{action}_keys").call(a_hash, from) if action == :deep_accept
        # result
        # # @result = t(:"#{action}_keys").call(a_hash,{from.to_sym => to.to_sym}) if action == :deep_rename
      end

      def t(*args)
        Transform::Transformer[*args]
      end
    end
  end
end

# rubocop:enable all

