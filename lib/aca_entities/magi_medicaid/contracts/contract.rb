# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Configuration values and shared rules and macros for {AcaEntities::Medicaid} validation contracts
      class Contract < Dry::Validation::Contract
        # config.messages.backend - the localization backend to use. Supported values are: :yaml and :i18n
        # config.messages.backend = :i18n
        # config.messages.default_locale - default I18n-compatible locale identifier
        # config.messages.default_locale = :en
        # config.messages.load_paths - an array of files paths that are used to load messages
        # config.messages.top_namespace - the key in the locale files under which messages are defined, by default it's dry_validation
        # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages

        rule(:aptc_effective_end_on, :aptc_effective_start_on) do
          if key?
            if values[:aptc_effective_end_on] < values[:aptc_effective_start_on]
              key.failure('must be after aptc_effective_start_on')
            end
          end
        end
      end
    end
  end
end
