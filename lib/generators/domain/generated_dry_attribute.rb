# frozen_string_literal: true

module Generators
  module Domain
    # Parse arguments into attributes for insertion into Dry Gem classes
    class GeneratedDryAttribute
      attr_reader :name, :type, :key_option

      KEY_OPTIONS = %w[required_key optional_key].freeze
      KEY_OPTION_DEFAULT = 'optional_key'
      TYPE_DEFAULT = 'string'
      DEFAULT_TYPES = %w[
        any
        nil
        symbol
        class
        true
        false
        bool
        integer
        float
        decimal
        string
        date
        date_time
        time
        array
        hash
      ].freeze

      class << self
        def parse(attribute_definition)
          name, type, key_option = attribute_definition.split(':')

          name = name.to_s if name
          type = type.nil? ? TYPE_DEFAULT : type.to_s
          key_option = key_option.nil? ? KEY_OPTION_DEFAULT : key_option.to_s

          # rubocop:disable Style/IfUnlessModifier
          unless valid_type?(type)
            raise ArgumentError, "Could not generate attribute '#{name}' with unknown type '#{type}'"
          end

          unless valid_key_option?(key_option)
            raise ArgumentError, "Could not generate attribute '#{name}' with unknown key option '#{key_option}'"
          end

          # rubocop:enable Style/IfUnlessModifier

          new(name, type, key_option)
        end

        def valid_key_option?(option)
          return false if option.nil?
          KEY_OPTIONS.include?(option.to_s)
        end

        def valid_type?(type)
          return false if type.nil?
          DEFAULT_TYPES.include?(type.to_s)
        end
      end

      def initialize(name, type = nil, key_option = nil)
        @name = name
        @type = type || TYPE_DEFAULT
        @key_option = key_option || KEY_OPTION_DEFAULT
      end

      def key_required?
        key_option != KEY_OPTION_DEFAULT
      end
    end
  end
end
