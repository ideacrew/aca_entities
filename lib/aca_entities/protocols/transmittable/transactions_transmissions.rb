# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      # An indexed list of {Transaction Transmissions} with their associated {Transmission Transactions} and vice versa
      class TransactionsTransmissions < Dry::Struct

        attribute :transactions do
          attribute :transaction, Types::Hash.meta(omittable: false)
          attribute :transmissions, Types::Array.of(Types::Hash).meta(omittable: false)
        end

        attribute :transmissions do
          attribute :transmission, Types::Hash.meta(omittable: false)
          attribute :transactions, Types::Array.of(Types::Hash).meta(omittable: false)
        end
      end
    end
  end
end