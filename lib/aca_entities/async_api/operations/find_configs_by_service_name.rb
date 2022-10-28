# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module AsyncApi
    module Operations
      # Find AsyncApi configuration files for a given application or service and return as an
      # array of hashes
      class FindConfigsByServiceName
        send(:include, Dry::Monads[:result, :do, :try])

        ProtocolOptionDefaults = { load_publisher_operations: true, load_subscriber_operations: true }.freeze

        # @param params [Hash] opts The options to initialize MagiMedicaidApplicationEntity
        # @option opts [String] :service_name AcaEntities::AsyncApi::Types::ServiceNameKind
        # @return [Dry::Monads::Result]
        def call(params)
          params ||= {}
          options      = yield fetch_options(params[:options])
          service_name = yield validate_service_name(params)
          protocol = yield validate_protocol(params)
          config_file_names = yield find_config_files(service_name, options)
          config_params = yield parse_files(config_file_names, protocol)

          Success(config_params)
        end

        private

        def fetch_options(options)
          Success ProtocolOptionDefaults.merge(options || {})
        end

        def validate_service_name(params)
          return Success(nil) unless params[:service_name]
          value = AcaEntities::AsyncApi::Types::ServiceNameKind.try(params[:service_name])
          value.success? ? Success(value.input) : Failure(value.error)
        end

        def validate_protocol(params)
          return Success(nil) unless params[:protocol]
          value = AcaEntities::AsyncApi::Types::ProtocolNameKind.try(params[:protocol])
          value.success? ? Success(value.input) : Failure(value.error)
        end

        def find_config_files(service_name, options)
          files =
            if service_name && options[:load_publisher_operations] && options[:load_subscriber_operations]
              Gem.find_files("aca_entities/async_api/#{service_name}/**/*.yml")
            elsif service_name && options[:load_publisher_operations]
              Gem.find_files("aca_entities/async_api/#{service_name}/**/*_publish.yml")
            elsif service_name && options[:load_subscriber_operations]
              Gem.find_files("aca_entities/async_api/#{service_name}/**/*_subscribe.yml")
            else
              Gem.find_files("aca_entities/async_api/**/*.yml")
            end

          Success(files)
        end

        # rubocop:disable Style/MultilineBlockChain
        def parse_files(config_file_names, protocol = nil)
          configs =
            config_file_names.reduce([]) do |config_params, config_file_name|
              conf =
                Try() do
                  AcaEntities::Operations::Files::Read.new.call(
                    filename: config_file_name
                  )
                end.to_result.bind do |config_yml|
                  AcaEntities::Operations::Yaml::Deserialize.new.call(yaml: config_yml.success)
                end

              if conf.success? && (protocol.nil? || (resource_protocol(conf.success) && resource_protocol(conf.success) == protocol))
                config_params << conf.success
              end

              config_params
            end

          Success(configs)
        end

        def resource_protocol(resource_hash)
          return unless resource_hash['servers']
          return unless resource_hash['servers']['production']
          resource_hash['servers']['production']['protocol']&.to_s
        end
        # rubocop:enable Style/MultilineBlockChain
      end
    end
  end
end
