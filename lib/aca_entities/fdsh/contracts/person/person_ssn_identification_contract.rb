# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Contracts
      module Person
        # FDSH schema and validation rules for {AcaEntities::Fdsh::Person::PersonSSNIdentification}
        class PersonSSNIdentificationContract < AcaEntities::Fdsh::Contracts::Contract
          # @!method call(opts)
          # @param opts [Hash] the parameters to validate using this contract
          # @option opts [String] :IdentificationID Social Security Number without dash delimiters
          params do
            # configure { predicates(AcaEntities::Fdsh::Predicates) }
            required(:IdentificationID).filled(:string)
          end
        end
      end
    end
  end
end
