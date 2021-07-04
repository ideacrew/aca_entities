# frozen_string_literal: true

module AcaEntities
  module Attestations
    class Attestation < Dry::Struct
      attribute :attestations, Types::Hash.meta(omittable: false)
    end
  end
end
