# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          # Inheritence Contract Class
          class Contract < Dry::Validation::Contract
            config.messages.default_locale = 'en'
          end
        end
      end
    end
  end
end
