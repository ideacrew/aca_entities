module Ehs
  module ValueObjects
    class ExternalIdentifier < Sequent::ValueObject
      attrs(
        key: String,
        item: String,
        start_on: DateTime
      )
    end
  end
end