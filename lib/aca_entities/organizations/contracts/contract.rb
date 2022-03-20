# frozen_string_literal: true

module AcaEntities
  module Organizations
    module Contracts
      # Shared configuration for FDSH contracts
      class Contract < Dry::Validation::Contract
        config.messages.default_locale = 'en'
      end
    end
  end
end
