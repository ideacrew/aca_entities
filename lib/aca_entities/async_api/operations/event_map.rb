# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module AsyncApi
    module Operations
      # Find AsyncApi configuration files for a given application or service and return as an
      # array of hashes
      class EventMap
        send(:include, Dry::Monads[:result, :do, :try])

        # @param params [Hash] opts The options to initialize MagiMedicaidApplicationEntity
        # @option opts [String] :service_name AcaEntities::AsyncApi::Types::ServiceNameKind
        # @return [Dry::Monads::Result]
        def call
          config_files = yield find_async_api_config_files
          event_hash = yield parse_files(config_files)

          Success(event_hash)
        end

        private

        def find_async_api_config_files
          config_files = Gem.find_files('aca_entities/async_api/**/*.yml')
          Success(config_files)
        end

        # rubocop:disable Style/MultilineBlockChain
        def parse_files(config_files)
          result =
            config_files.reduce({}) do |all_pubsub, filename|
              config_yaml =
                Try() do
                  AcaEntities::Operations::Files::Read.new.call(
                    filename: filename
                  )
                end.to_result.bind do |file_content|
                  AcaEntities::Operations::Yaml::Deserialize.new.call(
                    yaml: file_content.success
                  )
                end

              async_api = config_yaml.success.deep_symbolize_keys
              channels = async_api[:channels]

              file_pubsub =
                channels.reduce({}) do |file_ops, channel_item|
                  file_ops.merge!(parse_channel_item(channel_item, filename))
                end
              all_pubsub.merge!(file_pubsub)
            end
          Success(result.compact)
        end

        # rubocop:enable Style/MultilineBlockChain

        def parse_channel_item(channel_item, source_file)
          channel_item
            .last
            .reduce({}) do |op_list, op|
              channel_item_key = channel_item.first
              op_key = op.last[:operationId]
              op_kind = "#{op.first}ers".to_sym
              bindings = op.last[:bindings]

              operation = {
                op_key => {
                  op_kind => {
                    description: op.last[:description],
                    protocol: bindings&.keys&.first || :empty_def,
                    bindings: bindings,
                    source_file: source_file,
                    channel_item_key: channel_item_key
                  }
                }
              }
              op_list.merge!(operation)
            end
        end
      end
    end
  end
end
