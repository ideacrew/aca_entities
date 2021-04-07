# frozen_string_literal: true

module Entities
  module People
    class PersonHealth < Dry::Struct

      attribute :is_tobacco_user,         Types::String.optional
      attribute :is_physically_disabled,  Types::String.optional
    end
  end
end