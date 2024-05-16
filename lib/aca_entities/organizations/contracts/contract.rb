# frozen_string_literal: true

module AcaEntities
  module Organizations
    module Contracts
      # Shared configuration for {AcaEntities::Organization} contracts
      class Contract < AcaEntities::Contracts::Contract
        config.messages.default_locale = 'en'
      end
    end
  end
end
