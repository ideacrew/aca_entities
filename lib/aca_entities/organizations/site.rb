# frozen_string_literal: true

module AcaEntities
  module Organizations
    class Site < Dry::Struct
      attribute :key, Types::String.meta(omittable: false)
      attribute :url, Types::String.meta(omittable: true)
      attribute :title, Types::String.meta(omittable: true)
      attribute :description, Types::String.meta(omittable: true)
      attribute :options,
                AcaEntities::Enterprises::Options.meta(omittable: true)
    end
  end
end
