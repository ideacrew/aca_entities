# frozen_string_literal: true

module AcaEntities
  module Error

    # @api private
    module ErrorInitalizer
      attr_reader :original

      # rubocop:disable Style/SpecialGlobalVars
      def initialize(msg, original = $!)
        super(msg)
        @original = original
      end
      # rubocop:enable Style/SpecialGlobalVars
    end

    # @api public
    class Error < StandardError
      include ErrorInitalizer
    end

    class LoadException < RuntimeError
      include ErrorInitalizer
    end

    # FeatureNotFoundError      = Class.new(Error)
    # DuplicateFeatureError     = Class.new(Error)
    # InitializationFileError   = Class.new(LoadException)
  end
end
