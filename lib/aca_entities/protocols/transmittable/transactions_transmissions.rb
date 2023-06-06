# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      # An indexed list of {Transaction Transactions} with their associated {Transmission Transmissions} and vice versa
      class TransactionsTransmissions < Dry::Struct

        attribute :transactions do
          attribute :transaction, AcaEntities::Protocols::Transmittable::Transaction.meta(omittable: false)
          attribute :transmissions, Types::Array.of(AcaEntities::Protocols::Transmittable::Transmission).meta(omittable: false)
        end

        attribute :transmissions do
          attribute :transmission, AcaEntities::Protocols::Transmittable::Transmission.meta(omittable: false)
          attribute :transactions, Types::Array.of(AcaEntities::Protocols::Transmittable::Transaction).meta(omittable: false)
        end
      end
    end
  end
end