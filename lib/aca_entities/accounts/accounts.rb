# frozen_string_literal: true

# dependencies
# external
require 'aca_entities/attestations/attestations'
require 'aca_entities/accounts/oauth/omniauth'

# contracts
require_relative 'contracts/profile_contract'
require_relative 'contracts/attributes_contract'
require_relative 'contracts/account_contract'
require_relative 'contracts/keycloak_credential_representation_contract'
require_relative 'contracts/keycloak_user_representation_contract'
require_relative 'contracts/user_contract'

# entities
require_relative 'profile'
require_relative 'account'
require_relative 'user'
require_relative 'keycloak_credential_representation'
require_relative 'keycloak_user_representation'
