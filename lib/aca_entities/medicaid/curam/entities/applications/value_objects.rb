module Ehs
  module Applications
    module ValueObjects
      class ProgramApplication < Sequent::ValueObject
        attrs(
          aggregate_id: String,
          program_type: String,
          status: String,
          last_updated_at: DateTime,
          meta: ::Ehs::ValueObjects::Meta
        )
      end
    end
  end
end