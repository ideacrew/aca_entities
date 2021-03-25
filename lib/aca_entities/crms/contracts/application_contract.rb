# frozen_string_literal: true

Dry::Validation.load_extensions(:monads)

# Configuration values and shared rules and macros for domain model validation contracts
class ApplicationContract < Dry::Validation::Contract
  config.messages.default_locale = :en

  # config.messages.backend = :i18n
  # config.messages.default_locale - default I18n-compatible locale identifier
  # config.messages.backend - the localization backend to use. Supported values are: :yaml and :i18n
  # config.messages.load_paths - an array of files paths that are used to load messages
  # config.messages.top_namespace - the key in the locale files under which messages are defined, by default it's dry_validation
  # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages

  # Process validation contracts in a standard manner
  # @param evaluator [Dry::Validation::Contract::Evaluator]

    rule(:user, :assigned_to) do
      if key? && value
        result = Users::UserContract.new.call(value)
        key.failure(text: "invalid user", error: result.errors.to_h) if result&.failure?
      end
    end

    rule(:subscribed_users).each do  |key, value|
      if key? && value
        result = Users::UserContract.new.call(value)
        key.failure(text: "invalid user", error: result.errors.to_h) if result&.failure?
      end
    end

    rule(:lead) do
      if key? && value
        result = Leads::LeadContract.new.call(value)
        key.failure(text: "invalid lead", error: result.errors.to_h) if result&.failure?
      end
    end

    rule(:contacts).each do |key, value|
      if key? && value
        result = Contacts::ContactContract.new.call(value)
        key.failure(text: "invalid account", error: result.errors.to_h) if result&.failure?
      end
    end

    rule(:opportunities, :contact_opportunities).each do |key, value|
      if key? && value
        result = Opportunities::OpportunityContract.new.call(value)
        key.failure(text: "invalid opportunity", error: result.errors.to_h) if result&.failure?
      end
    end

    rule(:clinical_monitoring_investigations).each do |key, value|
      if key? && value
        result = Investigations::ClinicalDetailedInvestigationContract.new.call(value)
        key.failure(text: "invalid clinical monitoring investigations", error: result.errors.to_h) if result&.failure?
      end
    end
    
end
