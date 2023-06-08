# frozen_string_literal: true

require 'singleton'

module AcaEntities
  module Protocols
    module Transmittable
      # A data model for a single project
      class JobRepository < Dry::Struct

        # @!attribute [r] jobs
        # The set of {AcaEntities::Protocols::Transmittable::Job Jobs}
        # registered with the {AcaEntities::Protocols::Transmittable::JobRepository JobRepository}
        # @return [Array<AcaEntities::Protocols::Transmittable::Job>]
        attribute :jobs, Types::Array.of(AcaEntities::Protocols::Transmittable::Job).meta(omittable: false)
      end
    end
  end
end


