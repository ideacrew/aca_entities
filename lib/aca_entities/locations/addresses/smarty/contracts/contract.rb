# frozen_string_literal: true

module AcaEntities
  module Locations
    module Addresses
      module Smarty
        module Contracts
          # Inheritence Contract Class
          class Contract < AcaEntities::Contracts::Contract
            config.messages.default_locale = 'en'
          end
        end
      end
    end
  end
end
