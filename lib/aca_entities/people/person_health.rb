# frozen_string_literal: true

module AcaEntities
  module People
    class PersonHealth < Dry::Struct

      attribute :is_tobacco_user,         Types::String.optional.meta(omittable: false)
      attribute :is_physically_disabled,  Types::Bool.optional.meta(omittable: false)
    end
  end
end