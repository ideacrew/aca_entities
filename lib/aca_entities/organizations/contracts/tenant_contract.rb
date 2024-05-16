# frozen_string_literal: true

module AcaEntities
  module Organizations
    module Contracts

      module Tenants
        PrimarySiteType = Types::Symbol.default(:primary)

        EnvironmentHash = Dry::Schema.Params do
          required(:key).value(Types::Environment)
          optional(:features).array(:hash)
          optional(:options).array(:hash)
        end

        class TenantContract < ResourceRegistry::Validation::ApplicationContract

          params do
            required(:key).value(:symbol)
            optional(:owner_organization_name).maybe(:string)
            optional(:owner_account_name).maybe(:string)
            optional(:options).array(:hash)

            optional(:subscriptions).array(:hash) do
              optional(:key).value(:symbol)
              optional(:id).maybe(:string)
              optional(:validator_id).maybe(:string)
              optional(:subscribed_on).maybe(Types::CallableDate)
              optional(:unsubscribed_on).maybe(type?: Date)
              optional(:options).array(:hash)
            end

            optional(:sites).array(:hash) do
              required(:key).maybe(PrimarySiteType)
              optional(:url).maybe(:string)
              optional(:title).maybe(:string)
              optional(:description).maybe(:string)
              optional(:options).array(:hash)

              optional(:environments).array(EnvironmentHash)
            end
          end

          rule(:sites).each do
            validation_errors = []
            if value[:environments]
              value[:environments].each do |environment|
                valid_environment_keys = [:production, :development, :test]

                if valid_environment_keys.include? environment[:key]

                  features = environment[:features] || []
                  options  = environment[:options] || []

                  features.each do |feature|
                    result = ResourceRegistry::Features::Validation::FeatureContract.new.call(feature)
                    next unless result && result.failure?
                    validation_errors << result.errors.messages.reduce([]) do |list, message|
                      list << { :features => [{ path: message.path }, { input: message.input.to_s }, { text: message.text.to_s }] }
                    end
                  end

                  options.each do |option|
                    result = ResourceRegistry::Options::Validation::OptionContract.call(option)
                    next unless result && result.failure?
                    validation_errors << result.errors.messages.reduce([]) do |list, message|
                      list << { :options => [{ path: message.path }, { input: message.input.to_s }, { text: message.text.to_s }] }
                    end
                  end

                else
                  validation_errors << { :environments => "invalid key: #{environment[:key]}" }
                end
              end
            end

            key.failure("validation failed: #{validation_errors.flatten}") unless validation_errors.empty?
          end

        end
      end
    end
  end
end
