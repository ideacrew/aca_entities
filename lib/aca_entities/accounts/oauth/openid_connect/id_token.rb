# frozen_string_literal: true

module AcaEntities
  module Accounts
    module OpenidConnect
      # Returns an (OpenIDConnect Identity Token)[https://openid.net/specs/openid-connect-core-1_0.html#IDToken]
      # (ID Token) representing the outcome of an authentication process. The ID Token contains at minimum an
      # identifier for the user (called the sub aka subject claim) and information about how and when the user
      # authenticated. It may also contain additional identity data.
      #
      # @example
      #
      # {
      #   "iss": "http://host1:14100/oauth2",
      #   "sub": "polypress",
      #   "aud": ["polypress","http://host1:14100/oauth2"],
      #   "exp": 1509626702,
      #   "iat": 1509623102,
      #   "auth_time": "1509623099159",
      #   "jti": "_UC4Ew-NUTYQsMOXCoMo0g",
      #   "at_hash": "5CnkOBb_Mk28GYJlhC_Srg",
      #   "azp": "polypress",
      #   "acr": "2",
      #   "sid": "gO5pDtJFt+7bH/YQC8QpUQ==~teJOlstvBcUXT8xXcmaIG1ppGMAmBLKqPuJUKnzLyX3spmDtWwgDm/qj5hhoyPhSiqAghOgFmE+kpsm8esEEsbZht+L5dkL27JUSUbAGBBmwlR/8QlxLTE0cEoNJ+9aJ",
      #   "amr": ["pwd"]
      # }
      class IdToken < Dry::Struct
        # @!attribute [r] iss
        # Returns Issuer identifier for the issuer of the response. The iss value is a case-sensitive URL using the https
        # scheme that contains scheme, host, and optionally, port number and path components and no query or
        # fragment components.
        #
        # @return [URI::HTTPS]
        attribute :iss, Types::String.meta(omittable: false)

        # @!attribute [r] sub
        # Returns Subject identifier, a locally unique and never reassigned identifier within the Issuer for the End-User,
        # which is intended to be consumed by the Client. It is a case-sensitive string, maximum 255 characters
        #
        # @return [String]
        attribute :sub, Types::String.meta(omittable: false)

        # @!attribute [r] aud
        # Returns intended Audience(s) for this ID Token. It contains the OAuth 2.0 client_id of the Relying Party (RP) as an
        # audience value. It may also contain identifiers for other audiences.
        #
        # In the general case, the aud value is an array of case-sensitive strings.
        #
        # In the common special case when there is one audience, the aud value may be a single case-sensitive string
        #
        # @return [Array<String>]
        attribute :aud, Types::Array.of(String).meta(omittable: false)

        # @!attribute [r] exp
        # Returns Expiration time on or after which the ID Token MUST NOT be accepted by the Relying Party (RP) when performing
        # authentication with the OpenID Provider (OP).
        #
        # The current date/time MUST be before the expiration date/time listed in the value. Implementers MAY provide
        # for some small leeway, usually no more than a few minutes, to account for clock skew. Its value is a JSON
        # [RFC8259] number representing the number of seconds from 1970-01-01T00:00:00Z as measured in UTC until the
        # date/time. See RFC 3339 [RFC3339] for details regarding date/times in general and UTC in particular.
        #
        # NOTE: The ID Token expiration time is unrelated the lifetime of the authenticated session between the
        # RP and the OP.
        #
        # @return [Integer]
        attribute :exp, Types::Integer.meta(omittable: false)

        # @!attribute [r] iat
        # Returns Time at which the JWT was issued. Its value is a JSON number representing the number of seconds from
        # 1970-01-01T00:00:00Z as measured in UTC until the date/time.
        #
        # @return [Integer]
        attribute :iat, Types::Integer.meta(omittable: false)

        # @!attribute [r] auth_time
        # Returns Time when the End-User authentication occurred
        #
        # @return [String]
        attribute :auth_time, AcaEntities::Types::String.meta(omittable: false)

        # @!attribute [r] nonce
        # Value used to associate a Client session with an ID Token, and to mitigate replay attacks
        #
        # Note: nonce value is passed through unmodified from the Authentication Request to the ID Token. If present in the
        # ID Token, Clients MUST verify that the nonce Claim Value is equal to the value of the nonce parameter sent in the
        # Authentication Request. If present in the Authentication Request, Authorization Servers MUST include a nonce Claim in
        # the ID Token with the Claim Value being the nonce value sent in the Authentication Request. Authorization Servers
        # SHOULD perform no other processing on nonce values used.
        # #
        # @return [String]
        attribute :nonce, AcaEntities::Types::String.meta(omittable: false)

        # @!attribute [r] amr
        # Identifier for a family of closely related authentication methods
        # @return [Array<String>]
        attribute? :amr, AcaEntities::Types::Array.of(String).meta(omittable: true)

        # @!attribute [r] azp
        # Identifier of the party that is intended to use the access token and to request resources
        #
        # @return [String]
        attribute? :azp, AcaEntities::Types::String.meta(omittable: true)

        # @!attribute [r] sid
        # Value of the encrypted token that contains session identifier and details
        #
        # @return [String]
        attribute? :sid, AcaEntities::Types::String.meta(omittable: true)
      end
    end
  end
end
