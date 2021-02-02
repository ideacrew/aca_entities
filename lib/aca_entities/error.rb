# frozen_string_literal: true

module AcaEntities
  module Error

    # @api private
    module ErrorInitalizer
      attr_reader :original

      def initialize(msg, original = $!)
        super(msg)
        @original = original
      end
    end

    # @api public
    class Error < StandardError
      include ErrorInitalizer
    end

    class LoadException < LoadError
      include ErrorInitalizer
    end

    # FeatureNotFoundError      = Class.new(Error)
    # DuplicateFeatureError     = Class.new(Error)
    # InitializationFileError   = Class.new(LoadException)
  end
end
