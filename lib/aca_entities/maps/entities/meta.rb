# frozen_string_literal: true

module AcaEntities
  module Maps
    class Meta < Dry::Struct
      attribute :version,   Types::String.meta(omittable: true)
    end
  end
end