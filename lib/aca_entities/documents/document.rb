# frozen_string_literal: true

module AcaEntities
  module Documents
    class Document < Dry::Struct
      attribute :title,                           Types::String.optional.meta(omittable: true)
      attribute :creator,                         Types::String.optional.meta(omittable: true)
      attribute :subject,                         Types::String.optional.meta(omittable: true)
      attribute :description,                     Types::String.optional.meta(omittable: true)
      attribute :publisher,                       Types::String.optional.meta(omittable: true)
      attribute :contributor,                     Types::String.optional.meta(omittable: true)
      attribute :date,                            Types::Date.optional.meta(omittable: true)
      attribute :type,                            Types::String.optional.meta(omittable: true)
      attribute :format,                          Types::String.optional.meta(omittable: true)
      attribute :identifier,                      Types::String.optional.meta(omittable: true)
      attribute :source,                          Types::String.optional.meta(omittable: true)
      attribute :language,                        Types::String.optional.meta(omittable: true)
      attribute :relation,                        Types::String.optional.meta(omittable: true)
      attribute :coverage,                        Types::String.optional.meta(omittable: true)
      attribute :rights,                          Types::DocumentRights.optional.meta(omittable: true)
      attribute :tags,                            Types::Array.optional.meta(omittable: true)
      attribute :size,                            Types::String.optional.meta(omittable: true)
      attribute :doc_identifier,                  Types::String.optional.meta(omittable: true)
    end
  end
end
