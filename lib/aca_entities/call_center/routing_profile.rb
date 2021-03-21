# frozen_string_literal: true

module AcaEntities
  module CallCenter

    # Define a RoutingProfile together with its settings, code hook for dependency injection, and configuration UI attributes
    #
    # @example Define a routing_profile
    #   RoutingProfile.new()
    class RoutingProfile < Dry::Struct

      attribute :id,    Types::String.meta(omittable: false)
      attribute :arn,   Types::String.meta(omittable: false)
      attribute :name,  Types::String.meta(omittable: false)

    end
  end
end
