# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A collection of {Subject} instances that possess
    #   eligibility {Determinations}
    class Subjects < Dry::Struct
      attribute :subjects, Types::Hash.meta(omittable: false)
    end
  end
end
