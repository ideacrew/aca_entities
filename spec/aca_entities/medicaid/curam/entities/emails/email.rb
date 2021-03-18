# frozen_string_literal: true

module Ehs
  class Emails::Email < Dry::Struct

    attribute :type,    Types::EmailKind.meta(omittable: false)
    attribute :address, Types::String.meta(omittable: false)
  end
end
