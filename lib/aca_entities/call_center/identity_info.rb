# frozen_string_literal: true

module AcaEntities
  module CallCenter

    # Define a User together with its settings, code hook for dependency injection, and configuration UI attributes
    #
    # @example Define the phone_config
    #   IdentityInfo.new()
    class IdentityInfo < Dry::Struct

      attribute :first_name,  Types::String.meta(omittable: true)
      attribute :last_name,   Types::String.meta(omittable: true)
      attribute :email,       CallCenter::Types::Email.meta(omittable: true)

    end
  end
end