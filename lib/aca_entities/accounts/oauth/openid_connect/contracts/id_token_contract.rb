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
          # @option opts [String] :aud (Audience) intended Audience(s) for this ID Token (required)
          # @option opts [Integer] :exp (Expiry) the expiration time on or after which the ID Token MUST NOT be accepted
          # @option opts [Integer] :iat (Issued At) Time at which the JWT was issued (required)
          # @option opts [String] :acr (Authentication Context Class Reference) the level of assurance the user authenticated with
          # @option opts [Array<String>] :amr (Authentication Method Reference) how the user authenticated (optional)
          #   For example, ['pwd'] specifies the user authenticated with a password (optional)
          # @option opts [String] :azp (Authorized party) the party to which the ID Token was issued (optional)
          # @option opts [Integer] :nbf (Not Before) the starting time the JWT is valid (optional)
          # @option opts [String] :jti (JWT ID) a unique identifier for the token (optional)
          # @option opts [String] :sid (Session Identifier) the session ID (optional)
          # @option opts [String] :typ (Type) this token's type (optional)
          # @option opts [integer] :auth_time (Authentication Time) the time the user last authenticated (optional)
          # @option opts [String] :nonce (No more than Once) echoes the nonce value from the request to detect id token injection (optional)
          # @option opts [String] :at_hash (Access Token Hash) a string hash of the access token to detect access token injection (optional)
          # @option opts [String] :c_hash (Code Hash) a string hash of the code to detect code injection (optional)
          # @option opts [String] :s_hash (State Hash) a string hash of the state to detect state injection (optional)
          # @option opts [String] :sub_jwk (Subject JWK) a JSON Web Key (JWK) representing the subject's public key (optional)
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

            # Optional :acr, :amr, :azp, :jti, :sid, :auth_time, :nonce, :sub_jwk, :at_hash, :c_hash, :s_hash
            optional(:acr).maybe(:string)
            optional(:amr).array(:string)
            optional(:azp).maybe(:string)
            optional(:nbf).maybe(:string)
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
