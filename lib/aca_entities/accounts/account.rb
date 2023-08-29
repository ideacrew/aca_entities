# frozen_string_literal: true

module AcaEntities
  module Accounts
    # An OmniAuth 2 identity stored on a local service that represents a party (person or service) authenticated
    # through a # trusted third party service
    class Account < Dry::Struct
      attribute :id, Types::String.optional.meta(omittable: true)
      attribute :provider, Types::String.optional.meta(omittable: false)
      attribute :uid, Types::String.optional.meta(omittable: false)
      attribute :name, Types::String.optional.meta(omittable: false)
      attribute :email, AcaEntities::Types::EmailAddressKind.optional.meta(omittable: true)
    end
  end
end
