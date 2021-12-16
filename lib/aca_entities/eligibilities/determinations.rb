# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A collection of {Determination} instances
    class Determinations < Dry::Struct
      attribute :determinations, Types::Hash.meta(omittable: false)
    end
  end
end
