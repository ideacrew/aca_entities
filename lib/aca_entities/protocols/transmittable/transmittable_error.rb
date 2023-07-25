# frozen_string_literal: true

require 'singleton'

module AcaEntities
  module Protocols
    module Transmittable
      # A data model for a single project
      class TransmittableError < Dry::Struct

        attribute :key, Types::Symbol.optional.meta(omittable: true)
        attribute :message, Types::String.optional.meta(omittable: true)
      end
    end
  end
end


