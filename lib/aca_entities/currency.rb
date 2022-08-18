# frozen_string_literal: true

module AcaEntities
  class Currency < Dry::Struct

    attribute :cents,              Types::Money.default(0.0)
    attribute :currency_iso,       Types::String.default("USD")
  end
end
