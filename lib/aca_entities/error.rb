# frozen_string_literal: true

module AcaEntities
  module Error

    # @api private
    module ErrorInitalizer
      attr_reader :original

      def initialize(msg, original = $ERROR_INFO)
        super(msg)
        @original = original
      end
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
