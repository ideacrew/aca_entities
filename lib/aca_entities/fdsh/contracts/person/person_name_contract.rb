# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Contracts
      module Person
        # FDSH schema and validation rules for {AcaEntities::Fdsh::Person::PersonName}
        class PersonNameContract < AcaEntities::Fdsh::Contracts::Contract
          # @!method call(opts)
          # @param opts [Hash] the parameters to validate using this contract
          # @option opts [String] :PersonGivenName Applicant first name
          # @option opts [String] :PersonMiddleName Applicant middle name or initial (optional)
          # @option opts [String] :PersonSurName Applicant last name or family name
          params do
            required(:PersonGivenName).filled(:string)
            optional(:PersonMiddleName).maybe(:string)
            required(:PersonSurName).filled(:string)
          end
        end
      end
    end
  end
end
