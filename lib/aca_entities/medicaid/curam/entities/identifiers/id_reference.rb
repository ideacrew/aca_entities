# frozen_string_literal: true

module Ehs
  class Identifiers::IdReference < Dry::Struct

    attribute :source_system_key, Types::String.optional.meta(omittable: true)
    attribute :ids,               Types::Array.of(Ehs::Identifiers::Id).optional.meta(omittable: true)
  end
end
