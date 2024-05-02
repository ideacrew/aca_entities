# frozen_string_literal: true

module AcaEntities
  module Accounts
    module OpenidConnect
      module Contracts
        # Contract for validating a {AcaEntities::Accounts::OpenidConnect::IdToken} entity
        class IdTokenContract < Contract
          # @!method call(opts)
          # @option opts [String] :iss (Issuer) identifier for the issuer of the response (required)
          # @option opts [String] :sub (Subject) the issuer's unique identifier for the account holder (required)
          # @option opts [String] :aud (Audience) OAuth 2.0 client_ids of the Relying Party(s) (RP) (required)
          # @option opts [Array<String>] :amr (authentication method reference) how the user authenticated.
          #   For example, ['pwd'] specifies the user authenticated with a password (optional)
          # @option opts [Array<String>] :aud (Audience) intended Audience(s) for this ID Token (required)
          # @option opts [Integer] :nbf (not before) the time the JWT is valid from
          # @option opts [Integer] :exp (Expiry) the expiration time on or after which the ID Token MUST NOT be accepted
          # @option opts [Integer] :iat Time at which the JWT was issued (required)
          # @option opts [integer] :auth_time (Authentication Time) the time the user last authenticated
          # @option opts [String] :nonce (no more than once) echoes the nonce value from the request to detect id token injection
          # @option opts [String] :at_hash a string hash of the access token (detects access token injection)
          # @option opts [String] :sid (session identifier) the session ID
          # @option opts [String] :iat (issued at) the time the JWT was issued
          # @option opts [String] :typ (type) the type of token
          # @option opts [String] :azp (authorized party) the party to which the ID Token was issued
          # @option opts [String] :acr (authentication context class reference) the level of assurance the user authenticated with
          # @return [Dry::Monads::Success] if the payload passes validation
          # @return [Dry::Monads::Failure] if the payload fails validation
          json do
            # attr_required :iss, :sub, :aud, :exp, :iat
            required(:iss).filled(:string)
            required(:sub).filled(:string, max_size?: 255)
            # required(:aud).array(:string)
            required(:aud).filled(:string)
            required(:exp).filled(:integer)
            required(:iat).filled(:integer)

            # attr_optional :acr, :amr, :azp, :jti, :sid, :auth_time, :nonce, :sub_jwk, :at_hash, :c_hash, :s_hash
            optional(:acr).maybe(:string)
            optional(:amr).array(:string)
            optional(:azp).maybe(:string)
            optional(:jti).maybe(:string)
            optional(:sid).maybe(:string)
            optional(:auth_time).maybe(:integer)
            optional(:nonce).maybe(:string)

            # Additional attributes in Keycloak response
            optional(:typ).maybe(:string)
            optional(:sub_jwk).maybe(:string)
            optional(:at_hash).maybe(:string)
            optional(:c_hash).maybe(:string)
            optional(:s_hash).maybe(:string)
          end

          # rule(:exp, :iat) { key.failure('must be in the future') if value <= Time.now.gmtime.to_i }
        end
      end
    end
  end
end
