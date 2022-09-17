# frozen_string_literal: true

# dependencies
# external
require 'aca_entities/attestations/attestations'

# contracts
require_relative 'contracts/contract'
require_relative 'contracts/profile_contract'
require_relative 'contracts/attributes_contract'
require_relative 'contracts/identity_contract'
# require_relative 'contracts/user_contract'

# entities
require_relative 'profile'
require_relative 'identity'
# require_relative 'user'

# child entities
require_relative 'keycloak/keycloak'
require_relative 'omniauth/omniauth'
