# frozen_string_literal: true

module AcaEntities
  module Evidences
    # Entity for CodeDescription
    class CodeDescription < Dry::Struct
      attribute :kind, Types::String.optional.meta.(omittable: false)
      attribute :description, Types::String.optional.meta.(omittable: false)
    end
  end
end
