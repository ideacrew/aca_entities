# frozen_string_literal: true

module AcaEntities
  module Encryption
    module Symmetric
      # A payload from before we versioned our algorithms or keys.
      class LegacyEncryptedPayload
        attr_reader :content

        def initialize(content_value)
          @content = content_value
        end

        def header?
          false
        end
      end
    end
  end
end