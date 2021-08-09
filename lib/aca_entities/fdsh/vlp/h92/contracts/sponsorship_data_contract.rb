# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp SponsorshipData
        class SponsorshipDataContract < Dry::Validation::Contract
          params do
            required(:LastName).maybe(:string)
            required(:FirstName).maybe(:string)
            optional(:MiddleName).maybe(:string)
            optional(:Addr1).maybe(:string)
            optional(:Addr2).maybe(:string)
            optional(:City).maybe(:string)
            optional(:StateProvince).maybe(:string)
            optional(:ZipPostalCode).maybe(:string)
            optional(:SSN).maybe(:string)
            optional(:CountryCode).maybe(:string)
            optional(:CountryName).maybe(:string)
          end
        end
      end
    end
  end
end