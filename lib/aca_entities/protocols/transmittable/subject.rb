# frozen_string_literal: true

require 'dry-struct'

module AcaEntities
  module Protocols
    module Transmittable
      # A Subject is the Transmittable framework's Object of interest.  All jobs and metadata regarding transactions
      # and transmissions are associated with and reference a Subject.
      #
      # Transmittable uses composition to designate a domain entity as a Subject using {Dry:Struct::attributes_from}
      # to reference the {AcaEntities::Protocols::Transmittable::Subject Subject} schema.
      # schema.
      # @example For example, add it to your class like so:
      #
      # require 'aca_entities/libraries/protocols_library'
      #
      #  class MySubject < Dry::Struct
      #    attribute :id?, Types::Integer.meta(omittable: true)
      #    ...
      #    attributes_from AcaEntities::Protocols::Transmittable::Subject
      #    ...
      # end
      class Subject < Dry::Struct
        # @!attribute [r] transactions
        # The set of {AcaEntities::Protocols::Transmittable::Transaction Transactions} that belong to a Subject
        # @return [Array<AcaEntities::Protocols::Transmittable::Transaction>]
        attribute? :transactions, Types::Array
          .of(
            AcaEntities::Protocols::Transmittable::Transaction
          )
          .meta(omittable: true)
      end
    end
  end
end
