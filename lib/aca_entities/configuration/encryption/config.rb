# frozen_string_literal: true

module AcaEntities
  module Configuration
    module Encryption
      # load symmetric encryption configuration
      class Config
        attr_accessor :simple_box_secret_key
      end
    end
  end
end