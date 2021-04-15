# frozen_string_literal: true

Dry::Validation.load_extensions(:monads)

module AcaEntities
  module Medicaid
    module Curam
      # Configuration values and shared rules and macros for domain model validation contracts
      class ApplicationContract < Dry::Validation::Contract
        config.messages.default_locale = :en

        # config.messages.backend = :i18n
        # config.messages.default_locale - default I18n-compatible locale identifier
        # config.messages.backend - the localization backend to use. Supported values are: :yaml and :i18n
        # config.messages.load_paths - an array of files paths that are used to load messages
        # config.messages.top_namespace - the key in the locale files under which messages are defined, by default it's dry_validation
        # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages

        # Please don't do this here.  It impacts all contracts that could ever want to use this key.
        # rule(:person) do
        #   if key? && value
        #     if value.is_a?(Hash)
        #       result = People::PersonContract.new.call(value)
        #       if result&.failure?
        #         key.failure(text: 'invalid person', error: result.errors.to_h)
        #       else
        #         values.merge!(person: result.to_h)
        #       end
        #     else
        #       key.failure(text: 'invalid person. Expected a hash.')
        #     end
        #   end
        # end

        rule(:financial_statements) do
          if key? && value
            fin_stmts_array = value.inject([]) do |hash_array, rel_hash|
              if rel_hash.is_a?(Hash)
                result = FinancialStatements::FinancialStatementContract.new.call(rel_hash)
                if result&.failure?
                  key.failure(text: 'invalid financial statement', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid financial statement. Expected a hash.')
              end
              hash_array
            end
            values.merge!(financial_statements: fin_stmts_array)
          end
        end

        rule(:ids) do
          if key? && value
            identifiers_array = value.inject([]) do |hash_array, id_hash|
              if id_hash.is_a?(Hash)
                result = Identifiers::IdContract.new.call(id_hash)
                if result&.failure?
                  key.failure(text: 'invalid identifier', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid identifier. Expected a hash.')
              end
              hash_array
            end
            values.merge!(ids: identifiers_array)
          end
        end
      end
    end
  end
end
