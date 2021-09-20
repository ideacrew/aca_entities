# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Contract for RRV Medicare
        class CompletePersonNameContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param opts [Hash] the parameters to validate using this contract
          # @option opts [String] :PersonFirstName Applicant first name
          # @option opts [String] :PersonMiddleName Applicant middle name or initial (optional)
          # @option opts [String] :PersonLastName Applicant last name or family name
          params do
            required(:PersonFirstName).filled(:string)
            optional(:PersonMiddleName).maybe(:string)
            required(:PersonLastName).filled(:string)
            optional(:SuffixName).maybe(:string)
          end
        end
      end
    end
  end
end