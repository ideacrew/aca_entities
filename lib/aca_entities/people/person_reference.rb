# frozen_string_literal: true

module AcaEntities
  module People

    class PersonReference < Dry::Struct

      attribute :hbx_id,                    Types::String.meta(omittable: false)

      attribute :first_name,                Types::String.meta(omittable: false)
      attribute :middle_name,               Types::String.optional.meta(omittable: true)
      attribute :last_name,                 Types::String.meta(omittable: false)

      attribute :ssn,                       Types::String.optional.meta(omittable: true)
      attribute :no_ssn,                    Types::Strict::Bool.optional.meta(omittable: true)

      attribute :dob,                       Types::Date.meta(omittable: false)
      attribute :gender,                    Types::String.optional.meta(omittable: true)
    end
  end
end