# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp CertOfCitDocumentId
        class CertOfCitDocumentIdContract < Dry::Validation::Contract
          params do
            required(:AlienNumber).filled(:string)
            required(:CitizenshipNumber).filled(:string)
          end
        end
      end
    end
  end
end