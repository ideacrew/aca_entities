# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp CertOfCitDocumentId23Type
          class CertOfCitDocumentId23TypeContract < Dry::Validation::Contract
            params do
              required(:alienNumber).filled(:string)
              required(:citizenshipNumber).filled(:string)
            end
          end
        end
      end
    end
  end
end