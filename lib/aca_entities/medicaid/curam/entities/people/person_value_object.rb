# frozen_string_literal: true

module Ehs
  module People
    class PersonValueObject < Sequent::ValueObject
      attrs(
        ssn: String,
        prefix: String,
        first_name: String,
        last_name: String,
        middle_name: String,
        suffix: String,
        gender: String,
        date_of_birth: Date,
        last_updated_at: DateTime
      )

      def self.from_entity(person)
        params = person.to_h
        p_params = params.dup
        new(p_params.merge(p_params.delete(:person_name)))
      end
    end
  end
end
