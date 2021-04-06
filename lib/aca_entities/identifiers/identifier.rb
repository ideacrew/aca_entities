# frozen_string_literal: true

module AcaEntities
  module Identifiers
    class Identifier < Dry::Struct
      attribute :source_system_key, Types::String.optional.meta(omittable: true)
      attribute :ids,               Types::Array.of(AcaEntities::Identifiers::Id).optional.meta(omittable: true)
    end
  end
end
