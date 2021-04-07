# frozen_string_literal: true

module AcaEntities
  module Documents
    class RidpDocument < AcaEntities::Documents::Document
      attribute :status,                             Types::String.optional.meta(omittable: false)
      attribute :ridp_verification_type,             Types::String.optional.meta(omittable: false)
      attribute :comment,                            Types::String.optional.meta(omittable: false)
      attribute :uploaded_at,                        Types::Date.optional.meta(omittable: false)
    end
  end
end