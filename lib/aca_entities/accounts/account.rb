# frozen_string_literal: true

module AcaEntities
  module Accounts
    # A Keycloak Account
    class Account < Dry::Struct
      attribute :username, Types::String.optional.meta(omittable: true)
      attribute :email, Types::String.optional.meta(omittable: true)
      attribute :first_name, Types::String.optional.meta(omittable: true)
      attribute :last_name, Types::String.optional.meta(omittable: true)
      attribute :password, Types::String.optional.meta(omittable: true)
      attribute :attributes, Types::Hash.optional.meta(omittable: true)
      attribute :groups,
                Types::Array.of(Types::String).optional.meta(omittable: true)
      attribute :timestamps, AcaEntities::TimeStamp.meta(omittable: true)
    end
  end
end
