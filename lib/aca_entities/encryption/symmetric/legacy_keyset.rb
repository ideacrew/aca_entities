# frozen_string_literal: true

module AcaEntities
  module Encryption
    module Symmetric
      # Manages key settings for the 'original' implementation.
      class LegacyKeyset
        def self.secret_key
          key = AcaEntities::Configuration::Encryption.config.secret_key
          [key].pack("H*")
        end

        def self.iv
          AcaEntities::Configuration::Encryption.config.iv
        end
      end
    end
  end
end