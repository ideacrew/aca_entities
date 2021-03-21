# frozen_string_literal: true

module AcaEntities
  module CallCenter

    # Define a SecurityProfile together with its settings, code hook for dependency injection, and configuration UI attributes
    #
    # @example Define a security_profile
    #   SecurityProfile.new()
    class SecurityProfile < Dry::Struct

      attribute :id,    Types::String.meta(omittable: false)
      attribute :arn,   Types::String.meta(omittable: false)
      attribute :name,  Types::String.meta(omittable: false)

    end
  end
end
