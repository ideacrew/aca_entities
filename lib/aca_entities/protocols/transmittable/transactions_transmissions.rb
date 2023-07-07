# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      # An indexed list of {Transaction Transmissions} with their associated {Transmission Transactions}
      class TransactionsTransmissions < Dry::Struct
        attribute :transaction, Types::Hash.meta(omittable: false)
        attribute :transmission, Types::Hash.meta(omittable: false)
      end
    end
  end
end