# frozen_string_literal: true

require 'dry-struct'

module AcaEntities
  module Protocols
    module Transmittable
      # A Dry::Struct schema used for composing a Transmittable Subject Domain Entity -- the object to be
      # transmitted.
      # @example Add it to your class like so:
      #  class MySubject < Dry::Struct
      #    include Dry::Struct
      #    attribute :id?, Types::Integer.meta(omittable: true)
      #    ...
      #    attributes_from AcaEntities::Protocols::Transmittable::Subject
      #    ...
      # end
      class Subject < Dry::Struct
        # @!attribute [r] transactions
        # The set of {AcaEntities::Protocols::Transmittable::Transaction Transactions} that belong to a
        # {AcaEntities::Protocols::Transmittable::Subject Subject}
        # @return [Array<AcaEntities::Protocols::Transmittable::Transaction>]
        attribute? :transactions, Types::Array.of(AcaEntities::Protocols::Transmittable::Transaction).meta(omittable: true)
      end
    end
  end
end
