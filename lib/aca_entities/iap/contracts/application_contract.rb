# frozen_string_literal: true

Dry::Validation.load_extensions(:monads)

module Iap
  module Contracts
    # Configuration values and shared rules and macros for domain model validation contracts
    class ApplicationContract < Dry::Validation::Contract
      config.messages.default_locale = :en

      # config.messages.backend = :i18n
      # config.messages.default_locale - default I18n-compatible locale identifier
      # config.messages.backend - the localization backend to use. Supported values are: :yaml and :i18n
      # config.messages.load_paths - an array of files paths that are used to load messages
      # config.messages.top_namespace - the key in the locale files under which
      #   messages are defined, by default it's dry_validation
      # config.messages.namespace - custom messages namespace for a contract class.
      #   Use this to differentiate common messages

      # Process validation contracts in a standard manner
      # @param evaluator [Dry::Validation::Contract::Evaluator]

    end
  end
end
