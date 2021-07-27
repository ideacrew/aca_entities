# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp NatrOfCertDocumentId
        class NatrOfCertDocumentIdContract < Dry::Validation::Contract
          params do
            required(:NaturalizationNumber).filled(:string)
            optional(:AlienNumber).maybe(:string)
          end
        end
      end
    end
  end
end