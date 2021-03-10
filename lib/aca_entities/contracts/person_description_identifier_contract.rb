# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for PersonDescriptionIdentifier.
    class PersonDescriptionIdentifierContract < Dry::Validation::Contract

      params do
        optional(:is_full_time_student).maybe(:bool)
      end
    end
  end
end
