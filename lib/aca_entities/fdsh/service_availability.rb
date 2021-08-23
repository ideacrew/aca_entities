# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
module AcaEntities::Fdsh
  class ServiceAvailability

    attribute :service_key, AcaEntities::Fdsh::Types::ServiceKeyKind.meta(omittable: false)
    attribute :availability, Types::Array.of(AcaEntities::Fdsh::AvailabilityPeriod).meta(omittable: false)
    attribute :updated_at, Types::DateTime.meta(omittable: false)

  end
end
# rubocop:enable Style/ClassAndModuleChildren

# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
module AcaEntities::Fdsh
  class AvailabilityPeriod

    attribute :day_of_week
    attribute :start_at
    attribute :end_at
    attribute :time_zone

    attribute :service_key, AcaEntities::Fdsh::Types::ServiceKeyKind.meta(omittable: false)
    attribute :availability, Types::Array.of(AcaEntities::Fdsh::AvailabilityPeriod).meta(omittable: false)
    attribute :updated_at, Types::DateTime.meta(omittable: false)

  end
end
# rubocop:enable Style/ClassAndModuleChildren