# frozen_string_literal: true

module AcaEntities
  module Pdm
    module Entities
      # Manifest object and its attributes
      class Manifest < Dry::Struct
        # Type of manifest
        attribute :type, Types::ManifestTypes.meta(omittable: false)
        # aasistance year for the manifest
        attribute :assistance_year, Types::Integer.meta(omittable: false)
        # batch id related to the manifest
        attribute :batch_id, Types::String.optional.meta(omittable: true)
        # name of the file
        attribute :name, Types::String.optional.meta(omittable: true)
        # timestamp of the manifest execution
        attribute :timestamp, Types::Date.optional.meta(omittable: true)
        # response id
        attribute :response, Types::String.optional.meta(omittable: true)
        # number of requests
        attribute :count, Types::Integer.optional.meta(omittable: true)
        # request file was generated
        attribute :file_generated, Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
