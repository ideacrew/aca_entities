# frozen_string_literal: true

module AcaEntities
  module People
    class ResidentRole < Dry::Struct

      attribute :is_applicant,                          Types::Bool.optional.meta(omittable: true)
      attribute :is_active,                             Types::Bool.optional.meta(omittable: true)
      attribute :is_state_resident,                     Types::Bool.optional.meta(omittable: true)
      attribute :residency_determined_at,               Types::Date.optional.meta(omittable: true)
      attribute :contact_method,                        Types::String.optional.meta(omittable: true)
      attribute :language_preference,                   Types::String.optional.meta(omittable: true)

      attribute :local_residency_responses,             Types::Strict::Array.of(AcaEntities::Events::EventResponse).optional.meta(omittable: true)
      attribute :lawful_presence_determination,         Types::Strict::Array.of(AcaEntities::Determinations::LawfulPresenceDetermination).optional.meta(omittable: true)
    end
  end
end