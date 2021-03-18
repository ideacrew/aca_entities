# frozen_string_literal: true

module Ehs
  module Applications
    class Application < Dry::Struct

      # APPLICATIONID
      attribute :source_system_key,       Types::String.meta(omittable: true)
      attribute :ids,                     Types::Array.of(Ehs::Identifiers::Id).meta(omittable: false)
      attribute :status,                  Ehs::Types::ApplicationStatusKind.meta(omittable: false)
      attribute :status_code,             Ehs::Types::ApplicationStatusCodeKind.optional.meta(omittable: true)
      attribute :program_applications,    Types::Array.of(Applications::ProgramApplication).meta(omittable: false)
      attribute :people,                  Types::Array.of(People::Person).optional.meta(omittable: true)
      attribute :product_delivery_cases,  Types::Array.of(Ehs::ProductDeliveryCases::ProductDeliveryCase).optional.meta(omittable: true)
      attribute :last_updated_at,         Types::DateTime.meta(omittable: false)
      attribute :filing_date,             Types::Date.optional.meta(omittable: true)
      attribute :submitted_at,            Types::DateTime.meta(omittable: false)
    end
  end
end
