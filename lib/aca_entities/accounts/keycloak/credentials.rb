# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Keycloak
      # Keycloak API payload represntation of User credentials

      class Credentials < Dry::Struct
        attribute :algorithm, Types::String.optional.meta(omittable: true)
        attribute :config, Types::Hash.optional.meta(omittable: true)
        attribute :counter, Types::Integer.optional.meta(omittable: true)
        attribute :createdDate, Types::Integer.optional.meta(omittable: true)
        attribute :device, Types::String.optional.meta(omittable: true)
        attribute :digits, Types::Integer.optional.meta(omittable: true)
        attribute :hashIterations, Types::Integer.optional.meta(omittable: true)
        attribute :hashedSaltedValue, Types::String.optional.meta(omittable: true)
        attribute :period, Types::Integer.optional.meta(omittable: true)
        attribute :salt, Types::String.optional.meta(omittable: true)
        attribute :temporary, Types::Bool.optional.meta(omittable: true)
        attribute :type, Types::String.optional.meta(omittable: true)
        attribute :value, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
