# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets Document
    class Document < Dry::Struct

      attribute :title,               Types::Strict::String.meta(omittable: false)
      attribute :creator,             Types::Strict::String.meta(omittable: false)
      attribute :source,              Types::Strict::String.meta(omittable: false)
      attribute :language,            Types::Strict::String.meta(omittable: false)
      attribute :type,                Types::Strict::String.meta(omittable: false)
      attribute :format,              Types::Strict::String.meta(omittable: false)
      attribute :publisher,           Types::Strict::String.meta(omittable: false)

      attribute :subject,             Types::String.optional.meta(omittable: true)
      attribute :description,         Types::String.optional.meta(omittable: true)
      attribute :contributor,         Types::String.optional.meta(omittable: true)
      attribute :date,                Types::Date.optional.meta(omittable: true)
      attribute :identifier,          Types::String.optional.meta(omittable: true)
      attribute :relation,            Types::String.optional.meta(omittable: true)
      attribute :coverage,            Types::String.optional.meta(omittable: true)
      attribute :rights,              Types::String.optional.meta(omittable: true)
      attribute :tags,                Types::Array.optional.meta(omittable: true)
      attribute :size,                Types::String.optional.meta(omittable: true)
    end
  end
end