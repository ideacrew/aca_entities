# frozen_string_literal: true

module Transmittable
  # A mixin that enables domain model Transaction tracking using {Dry::Struct}
  module SubjectStruct
    extend ActiveSupport::Concern

    # @!attribute [r] transactions
    # A set of {Transmittable::Transactions} associated with a subject class
    # @return [Array<AcaEntities::Transmittable::Transaction>]
    attribute :transactions, Array.of(AcaEntities::Transmittable::Transaction).meta(omittable: false)
  end
end
