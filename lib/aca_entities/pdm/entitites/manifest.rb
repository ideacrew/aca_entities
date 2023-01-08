# frozen_string_literal: true

module AcaEntities
  module Pdm
    module Entities
      # Manifest object and its attributes
      class Manifest < Dry::Struct
        # Type of manifest
        attribute :type, Types::ManifestTypes.meta(omittable: false)

        attribute :assistance_year, Types::Integer.meta(omittable: false)

        attribute :batch_id, Types::String.optional.meta(omittable: true)

        attribute :name, Types::String.optional.meta(omittable: true)

        attribute :timestamp, Types::Date.optional.meta(omittable: true)

        attribute :response, Types::String.optional.meta(omittable: true)

        attribute :count, Types::Integer.optional.meta(omittable: true)

      end
    end
  end
end
