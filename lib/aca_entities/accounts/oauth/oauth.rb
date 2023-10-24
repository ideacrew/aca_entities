# frozen_string_literal: true

module AcaEntities
  module Accounts
    # OmniAuth 2.0 (OAuth) defines a common identity interface for use with third-party authentication services
    # known as Providers.
    # This implementation uses [Devise's integration](https://github.com/heartcombo/devise/wiki/OmniAuth:-Overview)
    # with [Omniauth](https://github.com/omniauth/omniauth).
    #
    # Community-supported plug-in adapters are available for numerous
    # [Providers](https://github.com/omniauth/omniauth/wiki/List-of-Strategies).
    module Oauth
      # external dependencies

      # local contracts
      require_relative 'contracts/contract'
      require_relative 'contracts/credentials_contract'
      require_relative 'contracts/info_contract'
      require_relative 'contracts/identity_contract'

      # local entities
      require_relative 'credentials'
      require_relative 'info'
      require_relative 'identity'
    end
  end
end
