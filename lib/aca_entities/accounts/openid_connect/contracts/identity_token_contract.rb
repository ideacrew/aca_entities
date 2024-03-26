# frozen_string_literal: true

module AcaEntities
  module Accounts
    module OpenidConnect
      module Contracts
        # Contract for validating a {AcaEntities::Accounts::OpenidConnect::IdentityToken} entity
        class IdentityTokenContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the attributes of an {AcaEntitiess::Identities::Omniauth::Auth}
          # @option opts [URI] :iss Issuer: identifier for the issuer of the response (required)
          # @option opts [String] :sub Subject: local, unique identifier for end user (required)
          # @option opts [Array<String>] :aud OAuth 2.0 client_ids of the Relying Party(s) (RP) (required)
          # @option opts [Integer] :exp Expiration time on or after which the ID Token MUST NOT be accepted by the
          #   Relying Party (RP) (required)
          # @option opts [Integer] :iat Time at which the JWT was issued (required)
          # @return [Dry::Monads::Success] if the payload passes validation
          # @return [Dry::Monads::Failure] if the payload fails validation
          JSON do
            # attr_required :iss, :sub, :aud, :exp, :iat
            required(:iss).filled(:string) #URI
            required(:sub).filled(:string, max_size?: 255)
            required(:aud).array(:string)
            required(:exp).filled(:integer)
            required(:iat).filled(:integer)
            required(:auth_time).filled(:string)
            required(:nonce).filled(:string)

            # attr_optional :acr, :amr, :azp, :jti, :sid, :auth_time, :nonce, :sub_jwk, :at_hash, :c_hash, :s_hash
            optional(:amr).array(:string)
            optional(:acr).maybe(:string)
            optional(:azp).maybe(:string)
            optional(:sid).maybe(:string)

            optional(:jti).maybe(:string)
            optional(:sub_jwk).maybe(:string)
            optional(:at_hash).maybe(:hash)
            optional(:s_hash).maybe(:hash)
          end

          rule(:exp, :iat) { key.failure('must be in the future') if value <= Time.now.gmtime.to_i }
        end
      end
    end
  end
end
