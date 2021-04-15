# frozen_string_literal: true

require_relative 'contracts/users/create_user_response_contract'
require_relative 'contracts/users/user_contract'
require_relative 'contracts/users/user_identity_info_contract'
require_relative 'contracts/users/user_list_contract'
require_relative 'contracts/users/user_phone_config_contract'
require_relative 'contracts/users/user_summary_contract'

module AcaEntities
  module CallCenter

    # Define a User together with its settings, code hook for dependency injection, and configuration UI attributes
    #
    # @example Define the user
    #   User.new(key: :greeter, item: proc { |name| "Hello #{name}!" })
    #   User.new(key: :logger, item: Logger.new(STDERR), settings: [{default: :warn}])
    class User < Dry::Struct

      # @!attribute [r] username (required)
      # Identifier for this User. Must be unique within a registry namespace
      # @return [Symbol]
      attribute :username,              Types::String.meta(omittable: false)

      # @!attribute [r] phone_config (required)
      # The registry phone_config where this item is stored
      # @return [Symbol]
      attribute :phone_config,          CallCenter::PhoneConfig.meta(omittable: false)

      # @!attribute [r] security_profile_ids  (required)
      # Availability state of this User in the application: either enabled or disabled
      # @return [true] If user is enabled
      # @return [false] If user is disabled
      attribute :security_profile_ids,  Types::Array.of(Types::String).meta(omittable: false)

      # @!attribute [r] routing_profile_id (required)
      # The reference or code to be evaluated when user is resolved
      # @return [Any]
      attribute :routing_profile_id,    Types::String.meta(omittable: false)

      # @!attribute [r] instance_id
      # Options passed through for item execution
      # The user-assigned values passed through for this configuratino setting
      # @return [Hash]
      attribute :instance_id,           Types::String.meta(omittable: false)

      # @!attribute [r] password (optional)
      # Configuration settings and attributes that support presenting and updating their values in the User Interface
      # @return [ResourceRegistry::Meta]
      attribute :password,              Types::String.meta(omittable: true)

      # @!attribute [r] identity_info (optional)
      # Configuration identity_info and values for this User
      # @return [Array<ResourceRegistry::Setting>]
      attribute :identity_info,         CallCenter::IdentityInfo.meta(omittable: true)

      # @!attribute [r] hierarchy_group_id (optional)
      # Configuration hierarchy_group_id and values for this User
      # @return [Array<ResourceRegistry::Setting>]
      attribute :hierarchy_group_id,    Types::String.meta(omittable: true)

      # @!attribute [r] hierarchy_group_id (optional)
      # Configuration hierarchy_group_id and values for this User
      # @return [Array<ResourceRegistry::Setting>]
      attribute :tags,                  Types::Hash.meta(omittable: true)

      # @!attribute [r] directory_user_id (optional)
      # Configuration directory_user_id and values for this User
      # @return [Array<ResourceRegistry::Setting>]
      attribute :directory_user_id,     Types::String.meta(omittable: true)

    end
  end
end

