# frozen_string_literal: true

module AcaEntities
  module Accounts
    # A Single Sign On (SSO) account for a person or service that is authenticated through a
    # trusted third party Provider services
    class Identity < Dry::Struct
      # @!attribute [r] id
      # Local service data store's unique identifier for this account
      # @return [String]
      attribute? :id, AcaEntities::Types::StringOrNil.meta(omittable: true)

      # @!attribute [r] provider
      # An identifier for the third party OAuth service that authenticated this account
      # @return [String]
      attribute :provider, Types::String.meta(omittable: false)

      # @!attribute [r] uid
      # A Provider-assigned unique identifier for this account
      # @return [Array<AcaEntities::Accounts::Identity>]
      attribute :uid, Types::String.meta(omittable: false)

      # @!attribute [r] created_at
      # The timestamp when this record was originally created in the data store
      # @return [AcaEntities::Types::TimeOrNil]
      attribute? :created_at, AcaEntities::Types::TimeOrNil.meta(ommittable: true)

      # @!attribute [r] updated_at
      # The timestamp when this record was last changed in the data store
      # @return [AcaEntities::Types::TimeOrNil]
      attribute? :updated_at, AcaEntities::Types::TimeOrNil.meta(ommittable: true)
    end
  end
end
