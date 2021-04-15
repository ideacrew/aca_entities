# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Applications
        # Curam application entity
        class Application < Dry::Struct

          # APPLICATIONID
          attribute :source_system_key,       Types::String.meta(omittable: true)
          attribute :ids,                     Types::Array.of(Curam::Identifiers::Id).meta(omittable: false)
          attribute :status,                  Curam::TypesApplicationStatusKind.meta(omittable: false)
          attribute :status_code,             Curam::TypesApplicationStatusCodeKind.optional.meta(omittable: true)
          attribute :program_applications,    Types::Array.of(Applications::ProgramApplication).meta(omittable: false)
          attribute :people,                  Types::Array.of(People::Person).optional.meta(omittable: true)
          attribute :product_delivery_cases,  Types::Array.of(Curam::ProductDeliveryCases::ProductDeliveryCase).optional.meta(omittable: true)
          attribute :last_updated_at,         Types::DateTime.meta(omittable: false)
          attribute :filing_date,             Types::Date.optional.meta(omittable: true)
          attribute :submitted_at,            Types::DateTime.meta(omittable: false)
        end
      end
    end
  end
end
