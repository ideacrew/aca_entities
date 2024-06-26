# frozen_string_literal: true

module AcaEntities
  module Verifications
    class VerificationType < Dry::Struct

      attribute :type_name,                                 Types::String.optional.meta(omittable: true)
      attribute :validation_status,                         Types::String.optional.meta(omittable: true)
      attribute :applied_roles,                             Types::Array.optional.meta(omittable: true)
      attribute :update_reason,                             Types::String.optional.meta(omittable: true)
      attribute :rejected,                                  Types::Bool.optional.meta(omittable: true)
      attribute :external_service,                          Types::String.optional.meta(omittable: true)
      attribute :due_date,                                  Types::Date.optional.meta(omittable: true)
      attribute :due_date_type,                             Types::String.optional.meta(omittable: true)
      attribute :updated_by,                                AcaEntities::People::PersonReference.optional.meta(omittable: true)
      attribute :inactive,                                  Types::Bool.optional.meta(omittable: true)

      attribute :vlp_documents,
                Types::Strict::Array.of(AcaEntities::Documents::VlpDocument).optional.meta(omittable: true)
      attribute :from_validation_status,                     Types::String.optional.meta(omittable: true)
      attribute :to_validation_status,                       Types::String.optional.meta(omittable: true)
    end
  end
end

