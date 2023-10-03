# frozen_string_literal: true

module AcaEntities
  module Encryption
    module Symmetric
      # Manages the selection of a key and algorithm using version headers
      class KeyManager
        def self.current_algo_version
          CURRENT_ALGO_VERSION
        end

        # Right now, since we're using the legacy configuration as our source,
        # we'll tag our key version as 'L'.
        def self.current_key_version
          "L"
        end

        # Eventually we will replace this with a dynamic lookup to allow key
        # rotation.
        def self.resolve_key(_algo_version, _key_version)
          LegacyKeyset.secret_key
        end
      end
    end
  end
end