# frozen_string_literal: true

module AcaEntities
  module Accounts
    # (OpenID Connect)[https://openid.net/] is a simple identity layer on top of the
    # {AcaEntities::Accounts::Oauth::Oauth OAuth 2.0} protocol (IETF RFC 6749 and 6750), which allows computing
    # clients to verify the identity of an end-user based on the authentication performed by an authorization
    # server, and to obtain basic profile information about the end-user in an interoperable and REST-like manner.
    #
    # OpenID Connect enables application and website sign-in flows and verifiable assertions about users across
    # Web-based, mobile, and JavaScript clients. The extensible specification supports a range of optional features,
    # such as identity data encryption, OpenID Provider discovery and session logout.
    #
    # OpenID Connect enables single sign-on (SSO) by delegating to identity providers (IDPs) the responsibility of
    # verifying a user's identity and releasing the minimum necessary identity information (claims) in a
    # secure, privacy-preserving manner. This allows users to authenticate with a single IDP over multiple domains and
    # application services, without having to re-enter credentials at each of them.
    #
    # **Terms**
    #
    #   **OpenID Provider (OP) or Identity Provider (IDP):** an entity that has implemented the OpenID Connect and
    #     OAuth 2.0 protocols, OP's can sometimes be referred to by the role it plays, such as: a security token
    #     service, an identity provider (IDP), or an authorization server
    #   **Client:** software that requests tokens either for authenticating a user or for accessing a resource
    #     (also often called a Relying Party or RP). A client must be registered with the OP. Clients can be
    #     web applications, native mobile and desktop applications, etc.
    #   **Relying Party (RP):** an application or website that outsources its user authentication function to an IDP
    #   **Identity Token (ID Token):** represents the outcome of an authentication process. It contains at a bare
    #     minimum an identifier for the user (called the sub aka subject claim) and information about how and when
    #     the user authenticated. It can contain additional identity data
    #   User: a person that is using a registered Client to access resources
    #
    module OpenidConnect
      # external dependencies

      # local contracts
      require_relative 'contracts/contract'
      require_relative 'contracts/extra_contract'
      require_relative 'contracts/info_token_contract'
      require_relative 'contracts/id_token_contract'

      # local entities
      require_relative 'id_token'
    end
  end
end
