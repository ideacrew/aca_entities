# frozen_string_literal: true

module AcaEntities
  module Configuration
    module Encryption
      # load symmetric encryption configuration
      class Config
        attr_accessor :secret_key, :iv
      end
    end
  end
end