# frozen_string_literal: true

module AcaEntities
  class Email < Dry::Struct

    attribute :kind, Types::EmailKind.optional.meta(omittable: true)
    attribute :address, Types::String.optional.meta(omittable: true)
    attribute :start_on, Types::Date.optional.meta(omittable: true)
    attribute :end_on, Types::Date.optional.meta(omittable: true)
  end
end
