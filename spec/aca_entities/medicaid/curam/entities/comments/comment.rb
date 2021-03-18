# frozen_string_literal: true

module Ehs
  class Comments::Comment < Dry::Struct
    attribute :id,            Types::Integer.optional.meta(omittable: true)
    attribute :content,       Types::String.meta(omittable: false)
    attribute :is_priority,   Types::Bool.default(false)
    attribute :priority,      Types::String.meta(omittable: false)
    attribute :updated_by,    Types::String.optional.meta(omittable: true)
    attribute :created_at,    Types::DateTime.optional.meta(omittable: true)
    attribute :updated_at,    Types::DateTime.optional.meta(omittable: true)
  end
end
