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

        # @param params [Hash] opts The options to initialize MagiMedicaidApplicationEntity
        # @option opts [String] :service_name AcaEntities::AsyncApi::Types::ServiceNameKind
        # @return [Dry::Monads::Result]
        def call(params)
          service_name = yield validate_service_name(params)
          config_file_names = yield find_config_files(service_name)
          config_params = yield parse_files(config_file_names)
          Success(config_params)
        end

        private

        def validate_service_name(params)
          return Success(nil) unless params[:service_name]
          value = AcaEntities::AsyncApi::Types::ServiceNameKind.try(params[:service_name])
          value.success? ? Success(value.input) : Failure(value.error)
        end

        def find_config_files(service_name)
          files =
            if service_name
              Gem.find_files("aca_entities/async_api/#{service_name}/**/*.yml")
            else
              Gem.find_files("aca_entities/async_api/**/*.yml")
            end
          Success(files)
        end

        # rubocop:disable Style/MultilineBlockChain
        def parse_files(config_file_names)
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
        # rubocop:enable Style/MultilineBlockChain
      end
    end
  end
end
