# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Contracts
      module Person
        # FDSH schema and validation rules for {AcaEntities::Fdsh::Person::PersonBirthDate}
        class PersonBirthDateContract < AcaEntities::Fdsh::Contracts::Contract
          # @!method call(opts)
          # @param [hash] opts the parameters to validate using this contract
          # @option opts [AcaEntities::Types::Date] :Date required

          params { required(:Date).filled(:date) }
        end
      end
    end
  end
end
