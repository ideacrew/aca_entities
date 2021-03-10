# frozen_string_literal: true

module AcaEntities
  class Attestation < Dry::Struct
    attribute :is_incarcerated,  Types::Bool.optional.meta(omittable: true)
  end
end
