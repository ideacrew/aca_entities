# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module AsyncApi
    module Operations
      # Find AsyncApi configuration files for a given application or service and return as an
      # array of hashes
      class EventMap
        include Dry::Monads[:do, :result, :try]

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
          # [
          #   '/Users/saikumar/Desktop/ideacrew/aca_entities/lib/aca_entities/async_api/enroll/amqp_h36_publish.yml',
          #   '/Users/saikumar/Desktop/ideacrew/aca_entities/lib/aca_entities/async_api/v3/enroll/amqp_h36_publish.yml'
          # ]

          Success(
            Gem.find_files("aca_entities/async_api/#{ASYNC_API_PATH}/**/*.yml")
          )
        end

        # rubocop:disable Style/MultilineBlockChain
        def parse_files(config_files)
          result =
            config_files.reduce({}) do |all_pubsub, filename|
              config_yaml =
                Try() do
                  AcaEntities::Operations::Files::Read.new.call(filename: filename)
                end.to_result.bind do |file_content|
                  AcaEntities::Operations::Yaml::Deserialize.new.call(yaml: file_content.success)
                end

              # channel_item2 = ::AcaEntities::Operations::Yaml::Deserialize.new.call(
              #   yaml: AcaEntities::Operations::Files::Read.new.call(
              #     filename: '/Users/saikumar/Desktop/ideacrew/aca_entities/lib/aca_entities/async_api/v3/enroll/amqp_h36_publish.yml'
              #   ).success
              # ).success.deep_symbolize_keys[:channels].to_a[0]

              # ::AcaEntities::Operations::Yaml::Deserialize.new.call(
              #   yaml: AcaEntities::Operations::Files::Read.new.call(
              #     filename: '/Users/saikumar/Desktop/ideacrew/aca_entities/lib/aca_entities/async_api/enroll/amqp_h36_publish.yml'
              #   ).success
              # ).success.deep_symbolize_keys

              async_api = config_yaml.success.deep_symbolize_keys
              # channels = async_api[:channels]

              # file_pubsub =
              #   channels.reduce({}) do |file_ops, channel_item|
              #     file_ops.merge!(parse_channel_item(channel_item, filename))
              #   end
              # all_pubsub.merge!(file_pubsub)

              all_pubsub.merge!(async_api[:channels])
            end
          Success(result.compact)
        end

        # rubocop:enable Style/MultilineBlockChain

        # channels
        # {
        #   :"enroll.h36.transmission_requested"=>{
        #     :bindings=>{
        #       :amqp=>{
        #         :is=>:routing_key,
        #         :exchange=>{
        #           :name=>"enroll.h36",
        #           :type=>"topic",
        #           :content_type=>"application/json",
        #           :durable=>true,
        #           :auto_delete=>false,
        #           :vhost=>"event_source"
        #         },
        #         :binding_version=>"0.2.0"
        #       }
        #     },
        #     :publish=>{
        #       :operationId=>"enroll.h36.transmission_requested",
        #       :description=>"Events - Publishes H36 transmission create",
        #       :bindings=>{
        #         :amqp=>{
        #           :app_id=>"enroll",
        #           :type=>"enroll.h36",
        #           :routing_key=>"enroll.h36.transmission_requested",
        #           :deliveryMode=>2,
        #           :mandatory=>true,
        #           :timestamp=>true,
        #           :content_type=>"application/json",
        #           :bindingVersion=>"0.2.0"
        #         }
        #       }
        #     }
        #   }
        # }

        # source_file "/Users/saikumar/Desktop/ideacrew/aca_entities/lib/aca_entities/async_api/enroll/amqp_h36_publish.yml"
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

        # {
        #   nil=>{
        #     :bindingsers=>{
        #       :description=>nil,
        #       :protocol=>:empty_def,
        #       :bindings=>nil,
        #       :source_file=>"/Users/saikumar/Desktop/ideacrew/aca_entities/lib/aca_entities/async_api/enroll/amqp_h36_publish.yml",
        #       :channel_item_key=>:"enroll.h36.transmission_requested"
        #     }
        #   },
        #   "enroll.h36.transmission_requested"=>{
        #     :publishers=>{
        #       :description=>"Events - Publishes H36 transmission create",
        #       :protocol=>:amqp,
        #       :bindings=>{
        #         :amqp=>{
        #           :app_id=>"enroll",
        #           :type=>"enroll.h36",
        #           :routing_key=>"enroll.h36.transmission_requested",
        #           :deliveryMode=>2,
        #           :mandatory=>true,
        #           :timestamp=>true,
        #           :content_type=>"application/json",
        #           :bindingVersion=>"0.2.0"
        #         }
        #       },
        #       :source_file=>"/Users/saikumar/Desktop/ideacrew/aca_entities/lib/aca_entities/async_api/enroll/amqp_h36_publish.yml",
        #       :channel_item_key=>:"enroll.h36.transmission_requested"
        #     }
        #   }
        # }
      end
    end
  end
end
