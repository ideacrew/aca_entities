# frozen_string_literal: true

# dependencies
# external
require 'aca_entities/attestations/attestations'
require 'aca_entities/accounts/oauth/oauth'
require 'aca_entities/accounts/openid_connect/openid_connect'
require 'aca_entities/accounts/keycloak/keycloak'

# contracts
require_relative 'contracts/contract'
require_relative 'contracts/attributes_contract'
require_relative 'contracts/identity_contract'
require_relative 'contracts/profile_contract'
require_relative 'contracts/account_contract'
require_relative 'contracts/user_contract'

# entities
require_relative 'identity'
require_relative 'profile'
require_relative 'account'
require_relative 'user'
