# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module AsyncApi
    # Extend DryTypes to include AsyncApi
    module Types
      send(:include, Dry.Types)

      ServiceNameKind =
        Types::Coercible::String.enum(
          'medicaid_gateway',
          'polypress',
          'fdsh_gateway',
          'enroll',
          'enroll_web'
        ).freeze

      ProtocolNameKind =
        Types::Coercible::String.enum(
          'http',
          'amqp'
        ).freeze
    end
  end
end
