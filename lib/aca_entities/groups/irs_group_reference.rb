# frozen_string_literal: true

module AcaEntities
  module Groups
    class IrsGroupReference < Dry::Struct

      attribute :hbx_id,     Types::String.optional.meta(omittable: false)
    end
  end
end
