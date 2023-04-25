# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Transmittable
    module Types
      send(:include, Dry.Types)
      send(:include, Dry::Logic)

      DefaultTransmitActionKind =
        Types::Coercible::String.enum(%i[blocked expired hold no_transmit pending transmit]).freeze

      DefaultTransmissionStatusKind = Types::Coercible::String.enum(%i[open pending processing transmitted]).freeze

      # A list of valid status values.  Override defaults using initializer options
      # acked: acknowledged
      # completed: processing of the object finished
      # nacked: negative_acknowledged, an outside service completed processing and indicated an error
      # pending: awaiting processing
      # blocked: transaction status when we do not need to transmit the latest transaction, usually upon receiving void when we never transmitted before
      DefaultTransactionStatusKind =
        Types::Coercible::String.enum(
          %i[
            approved
            acked
            blocked
            created
            completed
            denied
            errored
            excluded
            expired
            failed
            nacked
            pending
            rejected
            submitted
            successful
            superseded
            transmitted
          ]
        ).freeze
    end
  end
end
