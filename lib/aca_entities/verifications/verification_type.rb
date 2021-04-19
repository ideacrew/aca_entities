# frozen_string_literal: true

module AcaEntities
  module Verifications
    class VerificationType < Dry::Struct

      attribute :type_name,                                 Types::String.optional.meta(omittable: false)
      attribute :validation_status,                         Types::String.optional.meta(omittable: false)
      attribute :applied_roles,                             Types::Array.optional.meta(omittable: false)
      attribute :update_reason,                             Types::String.optional.meta(omittable: false)
      attribute :rejected,                                  Types::Bool.optional.meta(omittable: false)
      attribute :external_service,                          Types::String.optional.meta(omittable: false)
      attribute :due_date,                                  Types::Date.optional.meta(omittable: false)
      attribute :due_date_type,                             Types::String.optional.meta(omittable: false)
      attribute :updated_by,                                AcaEntities::People::PersonReference.optional.meta(omittable: true)
      attribute :inactive,                                  Types::Bool.optional.meta(omittable: false)

      attribute :vlp_documents,
                Types::Strict::Array.of(AcaEntities::Documents::VlpDocument).optional.meta(omittable: false)
    end
  end
end

