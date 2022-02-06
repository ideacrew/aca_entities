# frozen_string_literal: true

module AcaEntities
  module Locations
    module Smarty
      module Contracts
        # Inheritence Contract Class
        class Contract < Dry::Validation::Contract
          config.messages.default_locale = 'en'
        end
      end
    end
  end
end
