# frozen_string_literal: true

module AcaEntities
  module Attestations
    class Attestations < Dry::Stuct
      attribute :attestations, Types::Hash.meta(omittable: false)
    end
  end
end
