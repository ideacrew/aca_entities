# frozen_string_literal: true

module AcaEntities
  module Contacts
    class EmailContact < Dry::Struct

      attribute :kind,      AcaEntities::Types::EmailKind.meta(omittable: false)  # TODO: Revisit
      attribute :address,   Types::String.meta(omittable: false)
      attribute :start_on,  Types::Date.optional.meta(omittable: true)
      attribute :end_on,    Types::Date.optional.meta(omittable: true)
    end
  end
end
