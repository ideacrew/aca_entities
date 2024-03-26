# frozen_string_literal: true

module AcaEntities
  module Accounts
    # OmniAuth 2 (OAuth) is an open standard for access delegation, commonly used as a way for Internet users to
    # grant websites or applications access to their information on other websites but without giving them the
    # passwords. This is done using a token-based system. OAuth provides to clients a "secure delegated access".
    #
    # OAuth is commonly misunderstood to be an authentication protocol.  While it serves as a baseline protocol,
    # OAuth must be extended with an authentication protocol such as
    # {AcaEntities::Accounts::OpenIdConnect OpenID Connect} to provide secure authentication.
    #
    # OAuth defines a common identity interface for use with third-party authentication services
    # known as Providers. Providers are responsible for authenticating users and returning to client applications
    # basic user information.
    #
    # This implementation supports [Devise's integration](https://github.com/heartcombo/devise/wiki/OmniAuth:-Overview)
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
