# frozen_string_literal: true

module AcaEntities
  module CallCenter
    module Contracts
      module Users

        # Schema and validation rules for the {CallCenter::UserSummary} domain model
        class UserContract < Dry::Validation::Contract

          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :username (required) -> The user name for the account.
          # For instances not using SAML for identity management, the user name can include up to 20 characters.
          # If you are using SAML for identity management, the user name can include up to 64 characters from [a-zA-Z0-9_-.\@]+.
          # @option opts [Types::UserPhoneConfig] :phone_config (required) -> The phone settings for the user.
          # @option opts [Array<String>] :security_profile_ids (required) -> The identifier of the security profile for the user.
          # @option opts [String] :routing_profile_id (required) -> The identifier of the routing profile for the user.
          # @option opts [String] :instance_id (required) -> The identifier of the Amazon Connect instance.
          # @option opts [String] :password -> The password for the user account.
          # A password is required if you are using Amazon Connect for identity management.
          # Otherwise, it is an error to include a password.
          # @option opts [Types::UserIdentityInfo] :identity_info -> The information about the identity of the user.
          # @option opts [String] :hierarchy_group_id -> The identifier of the hierarchy group for the user.
          # @option opts [Hash] :tags -> One or more tags.
          # @option opts [String] :directory_user_id -> The identifier of the user account in the directory used for identity management.
          # If Amazon Connect cannot access the directory, you can specify this identifier to authenticate users.
          # If you include the identifier, we assume that Amazon Connect cannot access the directory.
          # Otherwise, the identity information is used to authenticate users from your directory.
          # This parameter is required if you are using an existing directory for identity management in Amazon Connect
          # when Amazon Connect cannot access your directory to authenticate users.
          # If you are using SAML for identity management and include this parameter, an error is returned.
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:username).filled(:string, max_size?: 20)
            required(:phone_config).filled(:hash)
            required(:security_profile_ids).array(:string)
            required(:routing_profile_id).filled(:string)
            required(:instance_id).filled(:string)

            optional(:password).maybe(:string)
            optional(:identity_info).maybe(:hash)
            optional(:hierarchy_group_id).maybe(:string)
            optional(:tags).maybe(:hash)

            optional(:directory_user_id).maybe(:string)
          end

        end
      end
    end
  end
end
