# frozen_string_literal: true

module AcaEntities
  class IdentifyingInformation < Dry::Struct

    attribute :ssn,       Types::String.optional.meta(omittable: true)
    attribute :hbx_id,    Types::String.optional.meta(omittable: true)
  end
end
